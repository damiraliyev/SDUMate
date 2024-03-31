//
//  EditProfilePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit
import PhotosUI
import PromiseKit

protocol IEditProfilePresenter: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func doneTapped()
    func cancelTapped()
    func didSelectRowAt(_ indexPath: IndexPath)
    func getViewModel(forCellAt indexPath: IndexPath) -> EditProfileCellViewModel?
}

final class EditProfilePresenter: NSObject, IEditProfilePresenter {
    
    weak var view: IEditProfileView?
    private weak var coordinator: IEditProfileCoordinator?
    private let sections = EditProfileTableSectionType.allCases
    private let authManager: AuthManager
    private let storageManager: StorageManager
    private let userManager: UserManager
    private var user: DBUser?
    private let editableUserInfo = EditableUserInfo()
    
    init(view: IEditProfileView, coordinator: IEditProfileCoordinator, container: DependencyContainer, user: DBUser?) {
        self.view = view
        self.coordinator = coordinator
        self.authManager = container.resolve(AuthManager.self)!
        self.storageManager = container.resolve(StorageManager.self)!
        self.userManager = container.resolve(UserManager.self)!
        self.user = user
    }
    
    func viewDidLoad() {
        if user == nil {
            guard let id = authManager.getAuthUser()?.uid else { return }
            userManager.getUser(userId: id).done { dbUser in
                self.user = dbUser
            } .catch { [weak self] error in
                self?.coordinator?.showErrorAlert(error: error.localizedDescription)
            }
        }
    }
    
    func viewDidAppear() {
        print("EDITED USER INFO", editableUserInfo)
    }
    
    func doneTapped() {
        coordinator?.popModule(completion: { [weak self] in
            self?.coordinator?.onFlowDidFinish?()
        })
    }
    
    func cancelTapped() {
        coordinator?.popModule(completion: { [weak self] in
            self?.coordinator?.onFlowDidFinish?()
        })
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        coordinator?.showEditFieldView(for: item, editableUserInfo: editableUserInfo)
    }
    
    func getViewModel(forCellAt indexPath: IndexPath) -> EditProfileCellViewModel? {
        guard let user = user else { return nil }
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        let title = item.title
        let value = switch item {
        case .name: user.name
        case .surname: user.surname
        case .nickname: user.nickname
        case .telegram: user.telegramTag
        case .email: user.email
        case .faculty: user.faculty?.rawValue
        case .profession: user.studyProgram?.rawValue
        case .yearOfEntering: "\(user.yearOfEntering ?? 0)"
        }
        guard let value = value else { return nil }
        let viewModel = EditProfileCellViewModel(title: title, value: value)
        return viewModel
    }
    
    func cameraTapped() {
        let options: [AttachmentOption] = [.camera, .photoLibrary]
        coordinator?.showPhotoSelectAlert(with: options, handler: self)
    }
    
    func saveProfileImage(data: Data) {
        guard let userId = authManager.getAuthUser()?.uid else { return }
        firstly {
            userManager.getUser(userId: userId)
        }.done { [weak self] dbUser in
            guard let self else { return }
            self.user = dbUser
            if let imagePath = dbUser.profileImagePath {
                firstly {
                    self.deleteImage(for: imagePath)
                } .done {
                    self.uploadImageToStorage(userId: userId, data: data)
                } .catch { error in
                    self.coordinator?.showErrorAlert(error: error.localizedDescription)
                }
            } else {
                self.uploadImageToStorage(userId: userId, data: data)
            }
        } .catch { [weak self] error in
            self?.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    private func deleteImage(for path: String, completion: @escaping (() -> Void))  {
        storageManager.deleteImage(path: path) { error in
            guard error == nil else {
                self.coordinator?.showErrorAlert(error: "Couldn't delete image.")
                return
            }
            completion()
        }
    }
    
    private func deleteImage(for path: String) -> Promise<Void> {
        return Promise { seal in
            firstly {
                storageManager.deleteImage(path: path)
            } .done { _ in
                seal.fulfill(())
            } .catch { [weak self] error in
                self?.coordinator?.showErrorAlert(error: error.localizedDescription)
                seal.reject(error)
            }
        }
    }
    
    private func uploadImageToStorage(userId: String, data: Data) {
        firstly {
            self.storageManager.saveImage(userId: userId, data: data)
        } .done { metaResult in
            self.fetchImageUrl(path: metaResult.imagePath)
        } .catch { error in
            self.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
        
    }
    
    private func fetchImageUrl(path: String) {
        firstly {
            storageManager.getUrlForImage(path: path)
        } .done { [weak self] url in
            self?.user?.profileImageUrl = url.absoluteString
            self?.updateDBUser(path: path, newImageUrl: url.absoluteString)
        } .catch { [weak self] error in
            self?.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
    }
    
    private func updateDBUser(path: String, newImageUrl: String) {
        guard let userId = authManager.getAuthUser()?.uid else { return }
        firstly {
            userManager.setProfileImage(userId: userId, profileImagePath: path, profileImageUrl: newImageUrl)
        } .done { error in
            print("Success")
        } .catch { [weak self] error in
            self?.coordinator?.showErrorAlert(error: error.localizedDescription)
        }
        
    }
}

extension EditProfilePresenter: EditProfileHeaderDelegate {
    func selectPhotoTapped() {
        let options: [AttachmentOption] = [.camera, .photoLibrary]
        coordinator?.showPhotoSelectAlert(with: options, handler: self)
    }
}

extension EditProfilePresenter: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaType = info[.mediaType] as? String else { return }
        switch mediaType {
        case UTType.image.description:
            if let image = info[.originalImage] as? UIImage, let imageData = image.compressIfNeeded() {
                saveProfileImage(data: imageData)
            }
        default:
            break
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfilePresenter: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion:nil)
        results.enumerated().forEach { (_, item) in
            if item.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                handleImagePickerResult(item)
            }
        }
    }
    
    private func handleImagePickerResult(_ item: PHPickerResult) {
        item.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
            guard let image = object as? UIImage else { return }
            DispatchQueue.main.async {
                self.view?.set(image: image)
                if let data = image.compressIfNeeded() {
                    self.saveProfileImage(data: data)
                }
            }
        }
    }
}
