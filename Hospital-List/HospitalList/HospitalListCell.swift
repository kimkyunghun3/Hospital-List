//
//  HospitalListCell.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import UIKit

final class HospitalListCell: UITableViewCell {
    static var identifer: String {
        String(describing: Self.self)
    }

    private let saveTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3

        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        return label
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        return label
    }()

    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3

        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ hospital: Hospital) {
        saveTimeLabel.text = hospital.saveTime.fullDateString(.full)
        nameLabel.text = hospital.name
        addressLabel.text = hospital.address
    }

    private func setLayout() {
        contentView.addSubview(saveTimeLabel)
        contentView.addSubview(infoStackView)

        infoStackView.addArrangedSubviews(with: [nameLabel,addressLabel])

        saveTimeLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.infoStackView.snp.top).inset(-20)
        }

        infoStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}
