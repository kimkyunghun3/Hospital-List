//
//  HospitalListAPI.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import Foundation

import Alamofire

enum HospitalListAPI {
    case hospitalList(HospitalListRequestModel)
}

extension HospitalListAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .hospitalList:
            return "/B551182/hospInfoService1/getHospBasisList1"
        }
    }

    var parameters: Encodable? {
        switch self {
        case let .hospitalList(model):
            return model
        }
    }

    var method: HTTPMethod {
        switch self {
        case .hospitalList:
            return .get
        }
    }
}
