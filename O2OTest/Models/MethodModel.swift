//
//  MethodModel.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import Foundation

struct MethodModel: Codable {
    var mash_temp: [TempModel]?
    var fermentation: TempModel?
    var twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mash_temp = "mash_temp"
        case fermentation = "fermentation"
        case twist = "twist"

    }
    
}

struct TempModel: Codable {
    var temp: MetricModel?
    var duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case duration = "duration"

    }
    
}
