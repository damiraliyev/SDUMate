//
//  EditFieldViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 30.03.2024.
//

import UIKit

protocol IEditFieldView: Presentable {
    var presenter: IEditFieldPresenter? { get set }
    
    func set(initialValue: String?)
    func showError(withText text: String)
}

final class EditFieldViewController: BaseViewController, IEditFieldView {
    var presenter: IEditFieldPresenter?
    private let item: EditProfileTableItem
    
    private lazy var navigationBar = SMNavigationBar(title: "") { [weak self] in
        self?.presenter?.backTapped()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium20
        label.text = "Edit"
        return label
    }()
    
    private lazy var editTextFieldView: EditTextFieldView = {
        let view = EditTextFieldView()
        view.layer.cornerRadius = 12
        view.setPlaceholderText(text: "Value", textColor: .moduleDescription)
        return view
    }()
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tabItem
        label.font = .regular14
        label.text = "You can only change this value once within 14 days."
        label.numberOfLines = 0
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = ._FF453A
        label.font = .regular14
        label.numberOfLines = 0
        label.safeHide()
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ._0A84FF
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 13
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside
        )
        return button
    }()
    
    init(item: EditProfileTableItem) {
        self.item = item
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([navigationBar, titleLabel, editTextFieldView, warningLabel, errorLabel, saveButton])
        titleLabel.text = "Edit \(item.title)"
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(24)
        }
        editTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(editTextFieldView.snp.bottom).offset(9)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(editTextFieldView.snp.bottom).offset(9)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-57)
        }
    }
    
    func set(initialValue: String?) {
        editTextFieldView.set(text: initialValue)
    }
    
    func showError(withText text: String) {
        errorLabel.text = text
        errorLabel.safeShow()
        warningLabel.safeHide()
        editTextFieldView.layer.borderColor = UIColor._FF453A.cgColor
        editTextFieldView.layer.borderWidth = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.errorLabel.safeHide()
            self.warningLabel.safeShow()
            self.editTextFieldView.layer.borderColor = UIColor.clear.cgColor
            self.editTextFieldView.layer.borderWidth = 0
        }
    }
    
    @objc func saveTapped() {
        presenter?.saveTapped(for: item, value: editTextFieldView.getText())
    }
}
