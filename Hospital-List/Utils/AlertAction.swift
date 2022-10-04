//
//  AlertAction.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import UIKit

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let completion: (() -> Void)?
}
