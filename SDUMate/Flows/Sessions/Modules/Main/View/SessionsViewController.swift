//
//  SessionsViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

enum SessionSelection {
    case all
    case offer
    case request
    case collaborate
}

protocol ISessionsView: Presentable {
    var presenter: ISessionsPresenter? { get set }
    
    func reload()
    func showEmptyState()
    func hideEmptyState()
}

final class SessionsViewController: BaseViewController {
    
    var presenter: ISessionsPresenter?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold28
        label.text = "Active Sessions"
        return label
    }()
    
    private lazy var allButton: InsetButton = {
        let button = makeButtonsWithInset(title: "All")
        button.backgroundColor = ._222294
        button.addTarget(self, action: #selector(allTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var offerButton: InsetButton = {
        let button = makeButtonsWithInset(title: "Offer")
        button.addTarget(self, action: #selector(offerTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var requestButton: InsetButton = {
        let button = makeButtonsWithInset(title: "Request")
        button.addTarget(self, action: #selector(requestTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collaborateButton: InsetButton = {
        let button = makeButtonsWithInset(title: "Collaborate")
        button.addTarget(self, action: #selector(collaborateTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AnnouncementCell.self)
        collectionView.contentInset.top = 14
        collectionView.contentInset.bottom = 24
        collectionView.alwaysBounceVertical = true
        collectionView.isSkeletonable = true
        collectionView.register(SessionCell.self)
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    private let emptySessionsLabel: UILabel = {
        let label = UILabel()
        label.font = .regular20
        label.textColor = .lavender
        label.text = "There is no established session"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([titleLabel, allButton, offerButton, requestButton, collaborateButton, collectionView])
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(11)
            make.leading.equalTo(16)
        }
        allButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(54)
            make.height.equalTo(35)
        }
        offerButton.snp.makeConstraints { make in
            make.centerY.equalTo(allButton)
            make.leading.equalTo(allButton.snp.trailing).offset(4)
            make.height.equalTo(35)
        }
        requestButton.snp.makeConstraints { make in
            make.centerY.equalTo(allButton)
            make.leading.equalTo(offerButton.snp.trailing).offset(4)
            make.height.equalTo(35)
        }
        collaborateButton.snp.makeConstraints { make in
            make.centerY.equalTo(allButton)
            make.leading.equalTo(requestButton.snp.trailing).offset(4)
            make.height.equalTo(35)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(allButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeButtonsWithInset(title: String) -> InsetButton {
        let button = InsetButton(top: 3, leading: 12, bottom: 3, trailing: 12)
        button.backgroundColor = ._110F2F
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .medium16
        button.layer.cornerRadius = 10
        return button
    }
    
    @objc func allTapped(_ sender: UIButton) {
        colorNeededButton(neededButton: sender)
        presenter?.typeTapped(type: .all)
    }
    
    @objc func offerTapped(_ sender: UIButton) {
        colorNeededButton(neededButton: sender)
        presenter?.typeTapped(type: .offer)
    }
    
    @objc func requestTapped(_ sender: UIButton) {
        colorNeededButton(neededButton: sender)
        presenter?.typeTapped(type: .request)
    }
    
    @objc func collaborateTapped(_ sender: UIButton) {
        colorNeededButton(neededButton: sender)
        presenter?.typeTapped(type: .collaborate)
    }
    
    @objc func refreshData() {
        presenter?.viewDidLoad()
    }
    
    private func colorNeededButton(neededButton: UIButton) {
        let _ = [allButton, offerButton, requestButton, collaborateButton].map { button in
            if button != neededButton {
                button.backgroundColor = .clear
            }
        }
        neededButton.backgroundColor = ._222294
    }
}

extension SessionsViewController: ISessionsView {
    func reload() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
    
    func showEmptyState() {
        collectionView.backgroundView = emptySessionsLabel
    }
    
    func hideEmptyState() {
        collectionView.backgroundView = nil
    }
}

extension SessionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width - 32
        let height: CGFloat = 195
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}

extension SessionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SessionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if let session = presenter?.dataSource[indexPath.row] {
            cell.configure(with: session)
            cell.delegate = presenter as? SessionCellDelegate
        }
        return cell
    }
}

