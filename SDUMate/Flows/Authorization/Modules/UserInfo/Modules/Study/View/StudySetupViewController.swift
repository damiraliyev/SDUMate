//
//  StudySetupViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 02.03.2024.
//

import UIKit

protocol IStudySetupView: Presentable {
    var presenter: IStudySetupPresenter? { get set }
}

final class StudySetupViewController: BaseViewController, IStudySetupView {
    
    var presenter: IStudySetupPresenter?
    
    private lazy var navigationBar = SMNavigationBar(title: "Study") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let facultyFormView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Faculty")
        view.set(placeholderText: "Choose faculty", textColor: .white)
        view.set(leftImage: Asset.icCalendar.image)
        view.set(rightImage: Asset.icRangeChoice.image)
        return view
    }()
    
    private let studyProgramFormView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Program of study")
        view.set(placeholderText: "Choose program", textColor: .white)
        view.set(leftImage: Asset.icHat.image)
        view.set(rightImage: Asset.icRangeChoice.image)
        return view
    }()
    
    private let yearFormView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Year of entering")
        view.set(placeholderText: "Choose year", textColor: .white)
        view.set(leftImage: Asset.icCalendar.image)
        view.set(rightImage: Asset.icRangeChoice.image)
        return view
    }()
    
    private lazy var continueButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .medium16
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        self.view = AuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubviews([navigationBar, fieldsStackView, continueButton])
        let formViews = [facultyFormView, studyProgramFormView, yearFormView]
        fieldsStackView.addArrangedSubviews(formViews)
        formViews.forEach { $0.disableTextField() }
    }
    
    private func setupConstraints() {
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-48)
            make.height.equalTo(52)
        }
    }
    
    @objc func continueTapped() {
        presenter?.continueTapped()
    }
}
