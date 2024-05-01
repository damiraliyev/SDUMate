//
//  FilterViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit
import PanModal

struct CategoryFilter {
    let name: String
    var isChosen: Bool
}

protocol FilterViewDelegate: AnyObject {
    func filtersApplied(filter: AppliedFilter)
}

protocol IFilterView: Presentable {
    var presenter: IFilterPresenter? { get set }
    var delegate: FilterViewDelegate? { get set } 
    func configure(filter: AppliedFilter?)
}

final class FilterViewController: BaseViewController, IFilterView {
    
    var presenter: IFilterPresenter?
    weak var delegate: FilterViewDelegate?
    private var selectedType: AnnounceType?
    
    private var categories: [CategoryFilter] = [
        CategoryFilter(name: "Software Engineering", isChosen: false),
        CategoryFilter(name: "UI/UX Design", isChosen: false),
        CategoryFilter(name: "Calculus", isChosen: false),
        CategoryFilter(name: "Linear Algebra", isChosen: false)
    ]
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.icXCloseBold.image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold24
        label.text = "Search by filter"
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .medium20
        label.text = "Type"
        return label
    }()
    
    private let typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var offerTypeView: FilterAnnounceTypeView = {
        let view = FilterAnnounceTypeView(type: .offer)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(offerTapped))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var requestType: FilterAnnounceTypeView = {
        let view = FilterAnnounceTypeView(type: .request)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(requestTapped))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var collaborateType: FilterAnnounceTypeView = {
        let view = FilterAnnounceTypeView(type: .collaborate)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(collaborateTapped))
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var freeOnlyView: FreeOnlyView = {
        let view = FreeOnlyView()
        return view
    }()
    
    private lazy var resetFieldsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Reset fields", for: .normal)
        button.tintColor = .lavender
        button.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        return button
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ._d9d9d9
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.register(CategoryFilterCell.self)
        tableView.backgroundColor = ._110F2F
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var showResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show results", for: .normal)
        button.titleLabel?.font = .medium18
        button.setTitleColor(.dark, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showResultTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([closeButton, titleLabel, typeLabel, typesStackView, freeOnlyView, resetFieldsButton, lineView, tableView, showResultButton])
        typesStackView.addArrangedSubviews([offerTypeView, requestType, collaborateType])
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-27)
            make.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalTo(titleLabel)
        }
        typesStackView.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
        }
        [offerTypeView, requestType, collaborateType].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(35)
            }
        }
        freeOnlyView.snp.makeConstraints { make in
            make.top.equalTo(typesStackView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(16)
        }
        resetFieldsButton.snp.makeConstraints { make in
            make.centerY.equalTo(freeOnlyView)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(25)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(freeOnlyView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(0.5)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        showResultButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-32)
            make.height.equalTo(54)
        }
    }
    
    func configure(filter: AppliedFilter?) {
        guard let filter else { return }
        freeOnlyView.isSelected = filter.isFreeOnly
        filter.categories.forEach {
            for i in 0..<categories.count {
                if categories[i].name == $0 {
                    categories[i].isChosen = true
                }
            }
        }
        if let type = filter.type {
            configure(selectedType: type)
            selectedType = filter.type
        }
        tableView.reloadData()
    }
    
    private func configure(selectedType: AnnounceType) {
        switch selectedType {
        case .offer:
            offerTapped()
        case .request:
            requestTapped()
        case .collaborate:
            collaborateTapped()
        }
    }
    
    @objc func closeTapped() {
        presenter?.closeTapped()
    }
    
    @objc func offerTapped() {
        colorNeededTypeView(neededView: offerTypeView)
        processSelection(of: offerTypeView)
    }
    
    @objc func requestTapped() {
        colorNeededTypeView(neededView: requestType)
        processSelection(of: requestType)
    }
    
    @objc func collaborateTapped() {
        colorNeededTypeView(neededView: collaborateType)
        processSelection(of: collaborateType)
    }
    
    @objc func showResultTapped() {
        let selectedCategories = categories.filter {
            $0.isChosen == true
        }.map { filter in
            filter.name
        }
        let appliedFilter = AppliedFilter(type: selectedType, isFreeOnly: freeOnlyView.isSelected, categories: selectedCategories)
        delegate?.filtersApplied(filter: appliedFilter)
        presenter?.closeTapped()
    }
    
    @objc func resetTapped() {
        if let selectedType = selectedType {
            reset(type: selectedType)
        }
        freeOnlyView.isSelected = false
        for i in 0..<categories.count {
            categories[i].isChosen = false
        }
        tableView.reloadData()
    }
    
    private func processSelection(of view: FilterAnnounceTypeView) {
        if selectedType == view.type {
            selectedType = nil
        } else {
            selectedType = view.type
        }
    }
    
    private func colorNeededTypeView(neededView: FilterAnnounceTypeView) {
        [offerTypeView, requestType, collaborateType].forEach {
            if $0 != neededView {
                $0.backgroundColor = ._282645
            }
        }
        neededView.backgroundColor = neededView.type == selectedType ? ._282645 : ._222294
    }
    
    private func reset(type: AnnounceType) {
        switch type {
        case .offer:
            colorNeededTypeView(neededView: offerTypeView)
        case .request:
            colorNeededTypeView(neededView: requestType)
        case .collaborate:
            colorNeededTypeView(neededView: collaborateType)
        }
        selectedType = nil
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categories[indexPath.row].isChosen = !categories[indexPath.row].isChosen
        tableView.reloadData()
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryFilterCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: categories[indexPath.row])
        return cell
    }
}

extension FilterViewController: PanModalPresentable {
    var panScrollable: UIScrollView? { nil }
    
    var cornerRadius: CGFloat { 16 }
    
    var shouldRoundTopCorners: Bool { true }
    
    var topOffset: CGFloat { .zero }
    
    var showDragIndicator: Bool { false }
    
    var allowsDragToDismiss: Bool { true }
    
    var isHapticFeedbackEnabled: Bool { false }
    
    var panModalBackgroundColor: UIColor { .dark.withAlphaComponent(0.4) }
    
    var longFormHeight: PanModalHeight {
        .contentHeight(UIView.screenHeight * 0.8)
    }
}
