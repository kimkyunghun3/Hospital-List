//
//  UIView+.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/05.
//

import UIKit

protocol AddViewsable {}

extension AddViewsable where Self: UIView {
    func addSubViews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}

