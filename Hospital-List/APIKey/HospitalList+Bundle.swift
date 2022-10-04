//
//  HospitalList+Bundle.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/04.
//

import Foundation

extension Bundle {
    var clientKey: String {
        guard let file = self.path(forResource: "NaverMapClientId", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { fatalError("NaverMapClientId.plist에 API_KEY 설정을 해주세요.")}

        return key
    }

    var serviceKey: String {
        guard let file = self.path(forResource: "HospitalInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { fatalError("HospitalInfo.plist에 API_KEY 설정을 해주세요.")}

        return key
    }
}
