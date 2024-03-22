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

final class FilterViewController: BaseViewController {
    
    private var categories: [CategoryFilter] = [
        CategoryFilter(name: "Software Engineering", isChosen: false),
        CategoryFilter(name: "UI/UX Design", isChosen: false),
        CategoryFilter(name: "Calculus", isChosen: false),
        CategoryFilter(name: "Linear Algebra", isChosen: false)
    ]
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.icXCloseBold.image, for: .normal)
        button.tintColor = .white
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
    
    private let offerType = FilterAnnounceTypeView(type: .offer)
    
    private let requestType = FilterAnnounceTypeView(type: .request)
    
    private let collaborateType = FilterAnnounceTypeView(type: .collaborate)
    
    private let freeOnlyView = FreeOnlyView()
    
    private let resetFieldsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Reset fields", for: .normal)
        button.tintColor = .lavender
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
        tableView.backgroundColor = .background
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let showResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show results", for: .normal)
        button.titleLabel?.font = .medium18
        button.setTitleColor(.dark, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        view.addSubviews([closeButton, titleLabel, typeLabel, typesStackView, freeOnlyView, resetFieldsButton, lineView, tableView, showResultButton])
        typesStackView.addArrangedSubviews([offerType, requestType, collaborateType])
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
        [offerType, requestType, collaborateType].forEach {
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
