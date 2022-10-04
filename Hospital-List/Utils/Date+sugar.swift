//
//  Date+sugar.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import Foundation

extension Date {
    public enum FormatType: String {
        case full = "YYYY-MM-dd HH:mm:ss"

        var displayName: String {
            return self.rawValue
        }
    }

    func fullDateString(_ type: FormatType) -> String {
        Formatter.shared.dateFormat = type.displayName
        guard let dateString = Formatter.shared.string(for: self) else { return "" }
        return dateString
    }
}

