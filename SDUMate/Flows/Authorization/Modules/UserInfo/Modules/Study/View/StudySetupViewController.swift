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

private enum Constants {
    static let contentSize = "contentSize"
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
    
    private lazy var facultyFormView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Faculty")
        view.set(placeholderText: "Choose faculty", textColor: .white)
        view.set(leftImage: Asset.icCalendar.image)
        view.set(rightImage: Asset.icRangeChoice.image)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(facultyTapped))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var studyProgramFormView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Program of study")
        view.set(placeholderText: "Choose program", textColor: .white)
        view.set(leftImage: Asset.icHat.image)
        view.set(rightImage: Asset.icRangeChoice.image)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(studyProgramTapped))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var yearFormView: FormTextFieldView = {
        let view = FormTextFieldView()
        view.set(title: "Year of entering")
        view.set(placeholderText: "Choose year", textColor: .white)
        view.set(leftImage: Asset.icCalendar.image)
        view.set(rightImage: Asset.icRangeChoice.image)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(yearTapped))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var facultyTableView: UITableView = {
        let tableView = StudySetupViewsFactory.createOptionsTableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var studyProgramTableView: UITableView = {
        let tableView = StudySetupViewsFactory.createOptionsTableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.facultyTableView.addObserver(self, forKeyPath: Constants.contentSize, options: .new, context: nil)
        self.studyProgramTableView.addObserver(self, forKeyPath: Constants.contentSize, options: .new, context: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.facultyTableView.removeObserver(self, forKeyPath: Constants.contentSize)
        self.studyProgramTableView.removeObserver(self, forKeyPath: Constants.contentSize)
        super.viewWillDisappear(true)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if keyPath == Constants.contentSize {
            if let value = change?[.newKey], let tableView = object as? UITableView {
                let size  = value as! CGSize
                tableView.frame.size.height = size.height
            }
        }
    }
    
    private func setupViews() {
        view.addSubviews([navigationBar, fieldsStackView, facultyTableView, studyProgramTableView, continueButton])
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
    
    private func toggleDropDown(relativeTo view: UIView) {
        if view == facultyFormView {
            studyProgramTableView.alpha = 0
            expandDropDown(of: view, tableView: facultyTableView)
        } else {
            facultyTableView.alpha = 0
            expandDropDown(of: view, tableView: studyProgramTableView)
        }
        
    }
    
    private func expandDropDown(of view: UIView, tableView: UITableView) {
        let neededFrame = view.convert(view.bounds, to: self.view)
        tableView.frame = CGRect(
            x: neededFrame.origin.x,
            y: neededFrame.maxY + 10,
            width: facultyFormView.frame.width,
            height: 100
        )
        tableView.reloadData()
        tableView.layoutIfNeeded()
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: .transitionCrossDissolve) {
            tableView.alpha = tableView.alpha == 1 ? 0 : 1
        }
    }
    
    // MARK: - Actions
    
    @objc func facultyTapped() {
        presenter?.facultyFieldTapped()
        toggleDropDown(relativeTo: facultyFormView)
    }
    
    @objc func studyProgramTapped() {
        presenter?.studyProgramFieldTapped()
        toggleDropDown(relativeTo: studyProgramFormView)
    }
    
    @objc func yearTapped() {
        showDateAndTimePicker()
    }
    
    func showDateAndTimePicker() {
        let alert = UIAlertController(style: .alert)
        alert.addDatePicker(mode: .date, style: .inline, height: 280, minimumDate: nil, maximumDate: Date()) { date in
            self.presenter?.dateSelected(date: date)
        }
        alert.addAction(title: CoreL10n.cancel, style: .default) { _ in
            self.presenter?.dateSelectionCanceled()
        }
        alert.addAction(title: CoreL10n.done, style: .default) { _ in
            self.presenter?.dateSelectionConfirmed()
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    @objc func continueTapped() {
        presenter?.continueTapped()
    }
}

extension StudySetupViewController: UITableViewDelegate {
    
}

extension StudySetupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getOptionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DefaultCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: presenter?.getOption(by: indexPath) ?? "")
        return cell
    }
}
