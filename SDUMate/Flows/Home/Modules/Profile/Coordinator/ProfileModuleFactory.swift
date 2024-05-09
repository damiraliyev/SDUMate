//
//  ProfileModuleFactory.swift
//  SDUMate
//
//  Created by Damir Aliyev on 24.03.2024.
//

import UIKit
import PhotosUI

final class ProfileModuleFactory {
    
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeProfileView(coordinator: IProfileCoordinator, fromFlow: ProfileFromFlowType) -> IProfileView {
        let view: IProfileView = ProfileViewController(fromFlow: fromFlow)
        let presenter: IProfilePresenter = ProfilePresenter(view: view, coordinator: coordinator, container: container)
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
    
    func makeEditProfileCoordinator(navigationController: CoordinatorNavigationController, user: DBUser?) -> Coordinator & IEditProfileCoordinator {
        let coordinator: Coordinator & IEditProfileCoordinator = EditProfileCoordinator(
            router: Router(navigationController: navigationController),
            container: container,
            user: user
        )
        return coordinator
    }
    
    func makeFeedbacksView(userId: String, coordinator: IAnnouncementResponderInfoCoordinator) -> IFeedbacksView {
        let view: IFeedbacksView = FeedbacksViewController()
        let presenter: IFeedbacksPresenter = FeedbacksPresenter(view: view, coordinator: coordinator, userId: userId)
        view.presenter = presenter
        return view
    }
}
