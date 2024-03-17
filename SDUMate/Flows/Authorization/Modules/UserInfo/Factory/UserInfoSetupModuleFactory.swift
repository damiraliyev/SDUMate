//
//  UserInfoSetupModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit
import PhotosUI

final class UserInfoSetupModuleFactory {
    
    func makeAboutSetupView(coordinator: IUserInfoSetupCoordinator) -> IAboutSetupView {
        let view: IAboutSetupView = AboutSetupViewController()
        let presenter: IAboutSetupPresenter = AboutSetupPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func makeStudySetupViews(coordinator: IUserInfoSetupCoordinator, userInfo: UserInfo) -> IStudySetupView {
        let view: IStudySetupView = StudySetupViewController()
        let presenter: IStudySetupPresenter = StudySetupPresenter(view: view, coordinator: coordinator, userInfo: userInfo)
        view.presenter = presenter
        return view
    }
    
    func makePhotoSetupView(coordinator: IUserInfoSetupCoordinator, userInfo: UserInfo) -> IPhotoSetupView {
        let view: IPhotoSetupView = PhotoSetupViewController()
        let presenter: IPhotoSetupPresenter = PhotoSetupPresenter(view: view, coordinator: coordinator, userInfo: userInfo)
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
