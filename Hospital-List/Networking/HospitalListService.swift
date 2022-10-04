//
//  HospitalListService.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import Foundation

import RxSwift

struct HospitalListService {
    private let network: Networking

    init(network: Networking) {
        self.network = network
    }

    func hospitalList(_ model: HospitalListRequestModel) -> Single<HospitalResponse> {
        network.request(HospitalListAPI.hospitalList(model)).map()
    }
}
