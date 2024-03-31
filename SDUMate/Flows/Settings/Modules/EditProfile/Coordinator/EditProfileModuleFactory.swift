//
//  EditProfileModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import Foundation
import PhotosUI

final class EditProfileModuleFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeEditProfileView(coordinator: IEditProfileCoordinator, user: DBUser?) -> IEditProfileView {
        let view: IEditProfileView = EditProfileViewController()
        let presenter: IEditProfilePresenter = EditProfilePresenter(view: view, coordinator: coordinator, container: container, user: user)
        view.presenter = presenter
        return view
    }
    
    func makeEditFieldView(coordinator: IEditProfileCoordinator, item: EditProfileTableItem, editableUserInfo: EditableUserInfo, initialValue: String?) -> IEditFieldView {
        let view: IEditFieldView = EditFieldViewController(item: item)
        let presenter: IEditFieldPresenter = EditFieldPresenter(view: view, coordinator: coordinator, editableUserInfo: editableUserInfo, initialValue: initialValue)
        view.presenter = presenter
        return view
    }
    
    func makeCameraPicker(handler: UIImagePickerControllerDelegate & UINavigationControllerDelegate) -> UIImagePickerController {
        let view = UIImagePickerController()
        view.delegate = handler
        view.sourceType = .camera
        view.videoQuality = .typeHigh
        view.mediaTypes = [UTType.movie.description, UTType.image.description]
        return view
    }
    
    func makePhotoLibrary(handler: PHPickerViewControllerDelegate) -> UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = handler
        return picker
    }
}
