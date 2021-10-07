//
//  PagesModel.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/7/21.
//

import Foundation

struct PagesModel: Codable {
    var currentPage: String?
    var perPage: Int?
    var currentListCount: Int?
    
    init(currentPage:String, perPage:Int, currentCount:Int) {
        self.currentPage = currentPage
        self.perPage = perPage
        currentListCount = currentCount
    }
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "currentPage"
        case perPage = "perPage"
        case currentListCount = "currentListCount"

    }
    
}
