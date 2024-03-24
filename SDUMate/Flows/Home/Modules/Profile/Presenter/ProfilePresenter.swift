//
//  ProfilePresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import UIKit
import PhotosUI
import PromiseKit

protocol IProfilePresenter: AnyObject {
    func backTapped()
    func cameraTapped()
}

final class ProfilePresenter: NSObject, IProfilePresenter {
    
    weak var view: IProfileView?
    private weak var coordinator: IProfileCoordinator?
    private let authManager: AuthManager
    private let storageManager: StorageManager
    private let userManager: UserManager
    private var user: DBUser?
    
    init(view: IProfileView, coordinator: IProfileCoordinator, container: DependencyContainer) {
        self.view = view
        self.coordinator = coordinator
        self.authManager = container.resolve(AuthManager.self)!
        self.storageManager = container.resolve(StorageManager.self)!
        self.userManager = container.resolve(UserManager.self)!
    }
    
    func backTapped() {
        coordinator?.backTapped { [weak self] in
            self?.coordinator?.onFlowDidFinish?()
        }
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

extension ProfilePresenter: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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

extension ProfilePresenter: PHPickerViewControllerDelegate {
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
