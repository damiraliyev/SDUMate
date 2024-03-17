//
//  PhotoSetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 03.03.2024.
//

import UIKit
import PhotosUI

protocol IPhotoSetupPresenter: AnyObject {
    func backTapped()
    func addPhotoTapped()
    func skipForNowTapped()
}

final class PhotoSetupPresenter: NSObject, IPhotoSetupPresenter {
    
    weak var view: IPhotoSetupView?
    private weak var coordinator: IUserInfoSetupCoordinator?
    private let userInfo: UserInfo
    private let authManager: AuthManager
    private let storageManager: StorageManager
    
    init(view: IPhotoSetupView, coordinator: IUserInfoSetupCoordinator, userInfo: UserInfo, container: DependencyContainer) {
        self.view = view
        self.coordinator = coordinator
        self.userInfo = userInfo
        self.authManager = container.resolve(AuthManager.self)!
        self.storageManager = container.resolve(StorageManager.self)!
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func addPhotoTapped() {
        let options: [AttachmentOption] = [.camera, .photoLibrary]
        coordinator?.showPhotoSelectAlert(with: options, handler: self)
    }
    
    func skipForNowTapped() {
        
    }
    
    func saveProfileImage(data: Data) {
        guard let userId = authManager.getAuthUser()?.uid else { return }
        storageManager.saveImage(userId: userId, data: data) { result in
            switch result {
            case .success(let metaResult):
                self.userInfo.profileImagePath = metaResult.imagePath
                self.fetchImageUrl(path: metaResult.imagePath)
            case .failure(let error):
                self.coordinator?.showErrorAlert(error: error.description)
            }
        }
    }
    
    private func fetchImageUrl(path: String) {
        storageManager.getUrlForImage(path: path) { result in
            switch result {
            case .success(let url):
                self.userInfo.profileImageUrl = url.absoluteString
            case .failure:
                self.coordinator?.showErrorAlert(error: "Couldn't get image url.")
            }
        }
    }
}

extension PhotoSetupPresenter: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Did finish picking media with info")
        guard let mediaType = info[.mediaType] as? String else { return }
        switch mediaType {
        case UTType.image.description:
            if let image = info[.originalImage] as? UIImage, let imageData = image.compressIfNeeded() {
                print("IMAGE WAS SELECTED!!!")
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

extension PhotoSetupPresenter: PHPickerViewControllerDelegate {
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
