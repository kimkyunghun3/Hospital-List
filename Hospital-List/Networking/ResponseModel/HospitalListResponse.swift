//
//  HospitalListResponse.swift
//  Hospital-List
//
//  Created by Eddy on 2022/10/01.
//

import Foundation

// MARK: - HospitalResponse

struct HospitalResponse: Decodable {
    let response: Response
}

// MARK: - Response

struct Response: Decodable {
    let body: Body
}

// MARK: - Body

struct Body: Decodable {
    let items: Items
}

// MARK: - Items

struct Items: Decodable {
    let item: [Item]
}

// MARK: - Item

struct Item: Decodable {
    let address: String
    let name: String
    let xPos, yPos: Pos

    enum CodingKeys: String, CodingKey {
        case address = "addr"
        case name = "yadmNm"
        case xPos = "XPos"
        case yPos = "YPos"
    }
}

struct Pos: Decodable {
    let positionValue: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self.positionValue = x
            return
        }
        if let x = try? container.decode(String.self) {
            self.positionValue = Double(x) ?? 0.0
            return
        }
        throw DecodingError.typeMismatch(Pos.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Pos"))
    }
}

