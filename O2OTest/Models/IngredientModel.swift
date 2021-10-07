//
//  IngredientModel.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import Foundation

struct IngredientModel: Codable {
    var malt: [MaltModel]?
    var hops: [HopsModel]?
    var yeast: String?
    
    enum CodingKeys: String, CodingKey {
        case malt = "malt"
        case hops = "hops"
        case yeast = "yeast"

    }
    
}

struct MaltModel: Codable {
    var name: String?
    var amount: MetricModel?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
    }
    
}

struct HopsModel: Codable {
    var name: String?
    var amount: MetricModel?
    var add: String?
    var attribute: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
        case add = "add"
        case attribute = "attribute"
    }
    
}
