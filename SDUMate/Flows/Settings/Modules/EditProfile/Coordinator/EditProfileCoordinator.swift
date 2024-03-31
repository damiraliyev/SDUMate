//
//  EditProfileCoordinator.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit
import PhotosUI

protocol IEditProfileCoordinator: IBaseCoordinator {
    var onFlowDidFinish: Completion? { get set }
    func popModule(completion: Completion?)
    func showEditFieldView(for item: EditProfileTableItem)
    func showPhotoSelectAlert(with options: [AttachmentOption], handler: PHPickerViewControllerDelegate & UIImagePickerControllerDelegate & UINavigationControllerDelegate)
}

final class EditProfileCoordinator: BaseCoordinator, IEditProfileCoordinator {
    var onFlowDidFinish: Completion?
    private let moduleFactory: EditProfileModuleFactory
    let permissionHelper: PermissionsHelper
    
    init(router: Router, container: DependencyContainer) {
        self.moduleFactory = EditProfileModuleFactory(container: container)
        self.permissionHelper = container.resolve(PermissionsHelper.self)!
        super.init(router: router)
    }
    
    override func start() {
        let editProfileView = moduleFactory.makeEditProfileView(coordinator: self)
        router.push(editProfileView)
    }
    
    func dismissModule(completion: (() -> Void)?) {
        router.dismissModule { [weak self] in
            completion?()
            self?.onFlowDidFinish?()
        }
    }
    
    func popModule(completion: Completion?) {
        router.popModule()
        completion?()
    }
    
    func showEditFieldView(for item: EditProfileTableItem) {
        let editFieldView = moduleFactory.makeEditFieldView(coordinator: self, item: item)
        router.push(editFieldView)
    }
    
    func showPhotoSelectAlert(with options: [AttachmentOption], handler: PHPickerViewControllerDelegate & UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        options.forEach { option in
            let action = UIAlertAction(title: option.name, style: .default) { [weak self] _ in
                self?.handleOptionSelected(option, handler: handler)
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: CoreL10n.cancel, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        router.presentAlert(alertController, animated: true)
    }
    
    private func handleOptionSelected(_ option: AttachmentOption, handler: PHPickerViewControllerDelegate & UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        switch option {
        case .camera:
            requestCameraAccess(handler: handler)
        case .photoLibrary:
            requestPhotoLibrary(handler: handler)
        }
    }
    
    func presentAlertForSettings(_ option: AttachmentOption) {
        let unavailableAlertController = UIAlertController(
            title: option.title,
            message: option.message,
            preferredStyle: .alert
        )
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = NSURL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsUrl as URL, options: [:], completionHandler: nil)
        }
        let cancelAction = UIAlertAction(title: CoreL10n.cancel, style: .cancel, handler: nil)
        unavailableAlertController.addAction(cancelAction)
        unavailableAlertController.addAction(settingsAction)
        router.present(unavailableAlertController as Presentable)
    }
    
    func requestCameraAccess(handler: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        permissionHelper.requestCameraAccess { [weak self] granted in
            granted ? self?.showCamera(handler: handler) : self?.presentAlertForSettings(.camera)
        }
    }
    
    func requestPhotoLibrary(handler: PHPickerViewControllerDelegate) {
        permissionHelper.requestLibraryAccess { [weak self] granted in
            granted ? self?.showPhotoLibrary(handler: handler) : self?.presentAlertForSettings(.photoLibrary)
        }
    }
    
    private func showCamera(handler: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let cameraView = moduleFactory.makeCameraPicker(handler: handler)
        router.present(cameraView)
    }
    
    private func showPhotoLibrary(handler: PHPickerViewControllerDelegate) {
        let photoLibrary = moduleFactory.makePhotoLibrary(handler: handler)
        router.present(photoLibrary)
    }
}
