//
//  InvitationsViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 22.03.2024.
//

import UIKit

protocol IInvitationsView: Presentable {
    var presenter: IInvitationsPresenter? { get set }
    
    func reload()
}

enum InvitationType: String, CaseIterable {
    case received = "Received"
    case sent = "Sent"
}

final class InvitationsViewController: BaseViewController, IInvitationsView {
    
    var presenter: IInvitationsPresenter?
    private let types = InvitationType.allCases
    
    private lazy var navigationBar = SMNavigationBar(title: "Invitations") { [weak presenter] in
        presenter?.backTapped()
    }
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Received", "Sent"])
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = ._222294
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, .font: UIFont.medium16]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = ._222294
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 10
        return segmentedControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AnnouncementCell.self)
        collectionView.register(InvitationDateHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.contentInset.top = 14
        collectionView.contentInset.bottom = 24
        collectionView.alwaysBounceVertical = true
        collectionView.isSkeletonable = true
        collectionView.register(InvitationReceivedCell.self)
        collectionView.register(InvitationSentCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = ._110F2F
        view.addSubviews([navigationBar, segmentedControl, collectionView])
    }
    
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(35)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func reload() {
        collectionView.reloadData()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        presenter?.typeChanged(to: types[sender.selectedSegmentIndex])
    }
}

extension InvitationsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width - 32
        let height: CGFloat = 72
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presenter?.didSelectItem(at: indexPath)
    }
}

extension InvitationsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.getSectionsCount() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getItemsCount(for: section) ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let cell: InvitationReceivedCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if let invitation = presenter?.getInvitation(for: indexPath) {
                cell.configure(with: invitation)
            }
            cell.delegate = presenter as? InvitationCellDelegate
            return cell
        default:
            let cell: InvitationSentCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if let invitation = presenter?.getInvitation(for: indexPath) {
                cell.configure(with: invitation)
            }
            cell.delegate = presenter as? InvitationCellDelegate
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 43)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView: InvitationDateHeaderView = collectionView.dequeueReuseableView(kind: UICollectionView.elementKindSectionHeader, indexPath)
            headerView.set(title: presenter?.getSectionTitle(for: indexPath.section))
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

