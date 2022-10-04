//
//  UIStackView+.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(with views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
