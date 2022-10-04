//
//  CommonRequest.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import Foundation

enum CommonRequest {
    enum ServiceKey: Encodable {
        case id

        func encode(to encoder: Encoder) throws {
            var contrainer = encoder.singleValueContainer()
            let serviceKey = Bundle.main.serviceKey

            switch self {
            case .id:
                try contrainer.encode(serviceKey)
            }
        }
    }

    enum type: Encodable {
        case type

        func encode(to encoder: Encoder) throws {
            var contrainer = encoder.singleValueContainer()

            switch self {
            case .type:
                try contrainer.encode("json")
            }
        }
    }
}
