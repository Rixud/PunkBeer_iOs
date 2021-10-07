//
//  MetricModel.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import Foundation

struct MetricModel: Codable {
    var value: Double?
    var unit: String?
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"

    }
    
}
