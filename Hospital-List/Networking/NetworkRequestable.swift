//
//  NetworkRequestable.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import UIKit

import Alamofire

protocol NetworkRequestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }

    func endpoint() throws -> URL
}

// MARK: - Builder

extension NetworkRequestable {
    func endpoint() throws -> URL {
        guard let endpoint = URL(string: baseURL + path) else {
            throw Network.NetworkingError.wrongEndpoint
        }
        return endpoint
    }
}

// MARK: - Preset

extension NetworkRequestable {
    var baseURL: String {
        "http://apis.data.go.kr"
    }

    var path: String {
        ""
    }

    var method: HTTPMethod {
        .get
    }

    var parameters: Encodable? {
        nil
    }
}
