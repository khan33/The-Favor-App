//
//  ServiceModel.swift
//  The Favour
//
//  Created by Atta khan on 26/06/2023.
//

import Foundation

struct ServiceModel: Decodable {
    let message: String?
    let error: Bool
    let data: [ServiceModelData]?
}

struct ServiceModelData: Decodable {
    let id: Int?
    let name: String?
    let color: String?
    let icon: String?
    let active: Bool?
    let ispopular: Bool
}
