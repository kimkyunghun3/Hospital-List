//
//  HospitalListButton.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import UIKit

final class HospitalListButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton() {
        self.setTitle("나의 위치 리스트 보기", for: .normal)
        self.setTitleColor(.white, for: .normal)
    }
}
