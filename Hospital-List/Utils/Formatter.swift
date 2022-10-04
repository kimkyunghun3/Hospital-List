//
//  Formatter.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import Foundation

struct Formatter {
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")

        return dateFormatter
    }()

    private init() {}
}
