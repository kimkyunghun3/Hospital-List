//
//  MainInfoView.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import UIKit

final class MainInfoView: UIView, AddViewsable {
    private let hospitalInfoLabel = UILabel()
    private let latLonLabel = UILabel()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        return label
    }()

    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = .init(top: 20, left: 0, bottom: 20, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually

        return stackView
    }()

    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("저장", for: .normal)

        return button
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.setTitleColor(.white, for: .normal)
        button.setTitle("취소", for: .normal)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setLayout()
        setShadow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 20)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 5.0
    }

    private func setLayout() {
        self.addSubViews([infoStackView, buttonStackView])

        infoStackView.addArrangedSubviews(with: [hospitalInfoLabel, latLonLabel, addressLabel])
        buttonStackView.addArrangedSubviews(with: [saveButton, cancelButton])

        infoStackView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(buttonStackView.snp.top)
        }

        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }

    func setData(item: Item) {
        hospitalInfoLabel.text = "병원명: \(item.name)"
        latLonLabel.text = "위경도: \(item.xPos.positionValue), \(item.yPos.positionValue)"
        addressLabel.text = "주소: \(item.address)"
    }
}
