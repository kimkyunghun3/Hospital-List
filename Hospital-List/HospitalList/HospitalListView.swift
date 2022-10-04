//
//  HospitalListView.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import UIKit

import RxSwift

final class HospitalListView: UIView, AddViewsable {
    let tableView =  UITableView()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.text = "병원 정보 저장 기록"

        return title
    }()

    let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)

        return button
    }()

    init() {
        super.init(frame: .zero)
        setTableView()
        setLayout()
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setTableView() {
        tableView.register(HospitalListCell.self, forCellReuseIdentifier: HospitalListCell.identifer)
    }


    private func setLayout() {
        self.addSubViews([tableView, titleLabel, exitButton])

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }

        exitButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
}
