//
//  StudyInfoDetailsView.swift
//  SDUMate
//
//  Created by Damir Aliyev on 21.03.2024.
//

import UIKit

final class StudyInfoDetailsView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let facultyInfoView = LabelWithLeftIconView(image: Asset.icHatClear.image, text: "Engineering and Natural Science")
    
    private let studyProgramView = LabelWithLeftIconView(image: Asset.icSuitcase.image, text: "Computer science")
    
    private let dateOfEnteringView = LabelWithLeftIconView(image: Asset.icHatClear.image, text: "2020")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = ._767680.withAlphaComponent(0.2)
        layer.cornerRadius = 15
        addSubview(stackView)
        stackView.addArrangedSubviews([facultyInfoView, studyProgramView, dateOfEnteringView])
        dateOfEnteringView.safeHide()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        [facultyInfoView, studyProgramView, dateOfEnteringView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(30)
            }
        }
    }
    
    func showDateOfEntering() {
        dateOfEnteringView.safeShow()
    }
}
