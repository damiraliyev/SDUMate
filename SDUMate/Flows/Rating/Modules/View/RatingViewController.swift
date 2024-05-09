//
//  RatingViewController.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit
import SkeletonView

protocol IRatingView: Presentable {
    var presenter: IRatingPresenter? { get set }
    func configureTops(goldUser: DBUser?, silverUser: DBUser?, bronzeUser: DBUser?)
    func showLoading()
    func hideLoading()
    func reload()
}

final class RatingViewController: BaseViewController, IRatingView {
    
    var presenter: IRatingPresenter?
    
    private let topContributorsLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .semibold28
        label.text = "Top contributors"
        return label
    }()
    
    private let glassButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.icLoupe.image, for: .normal)
        button.backgroundColor = ._110F2F
        return button
    }()
    
    private lazy var headerView = RatingHeaderView()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = ._110F2F
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ContributorCell.self)
        collectionView.isSkeletonable = true
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
        view.addSubviews([topContributorsLabel, headerView, collectionView])
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    private func setupConstraints() {
        topContributorsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(22)
            make.leading.equalToSuperview().offset(16)
        }
//        glassButton.snp.makeConstraints { make in
//            make.centerY.equalTo(topContributorsLabel)
//            make.trailing.equalToSuperview().offset(-16)
//            make.size.equalTo(19)
//        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(topContributorsLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(212)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(74)
                )
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(74)),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 11
            return section
        }
    }
    
    func configureTops(goldUser: DBUser?, silverUser: DBUser?, bronzeUser: DBUser?) {
        headerView.configure(goldUser: goldUser, silverUser: silverUser, bronzeUser: bronzeUser)
    }
    
    func showLoading() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        DispatchQueue.main.async {
            self.collectionView.startSkeletonAnimation()
            self.collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: ._282645),animation: animation)
        }
    }
    
    func hideLoading() {
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton()
    }
    
    func reload() {
        collectionView.reloadData()
    }
}

extension RatingViewController: UICollectionViewDelegate {

}

extension RatingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.usersDataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContributorCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        guard let user = presenter?.usersDataSource[safe: indexPath.item] else { return cell }
        cell.configure(with: user, place: indexPath.item + 3)
        return cell
    }
}

extension RatingViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return ContributorCell.defaultReuseIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}
