//
//  Encodable+Alamofire.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import Foundation

import Alamofire

extension Encodable {
    var requestable: Parameters {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
    }
}
