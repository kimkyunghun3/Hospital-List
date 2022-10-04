//
//  HospitalListRequestModel.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import Foundation

struct HospitalListRequestModel: Encodable {
    let yPos: Double
    let xPos: Double
    let ServiceKey: CommonRequest.ServiceKey
    let _type: CommonRequest.type
    let radius: Double
}
