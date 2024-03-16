//
//  StudySetupPresenter.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import Foundation

protocol IStudySetupPresenter: AnyObject {
    func backTapped()
    func continueTapped()
    func facultyFieldTapped()
    func studyProgramFieldTapped()
    func getOptionsCount() -> Int
    func getOption(by indexPath: IndexPath) -> String
}

private enum SelectableField {
    case faculty
    case studyProgram
}

final class StudySetupPresenter: IStudySetupPresenter {
    
    weak var view: IStudySetupView?
    private weak var coordinator: IUserInfoSetupCoordinator?
    private let userInfo: UserInfo
    
    private var selectedField: SelectableField = .faculty
    private let faculties: [Faculty] = Faculty.allCases
    private let studyPrograms: [StudyProgram] = StudyProgram.allCases
    
    init(view: IStudySetupView, coordinator: IUserInfoSetupCoordinator, userInfo: UserInfo) {
        self.view = view
        self.coordinator = coordinator
        self.userInfo = userInfo
    }
    
    func backTapped() {
        coordinator?.onBackTapped(completion: nil)
    }
    
    func continueTapped() {
        coordinator?.showPhotoSetupView()
    }
    
    func facultyFieldTapped() {
        selectedField = .faculty
    }
    
    func studyProgramFieldTapped() {
        selectedField = .studyProgram
    }
    
    func getOptionsCount() -> Int {
        switch selectedField {
        case .faculty:
            return faculties.count - 1
        case .studyProgram:
            return studyPrograms.count - 1
        }
    }
    
    func getOption(by indexPath: IndexPath) -> String {
        switch selectedField {
        case .faculty:
            return faculties[indexPath.row + 1].rawValue
        case .studyProgram:
            return studyPrograms[indexPath.row + 1].rawValue
        }
    }
}
