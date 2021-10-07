//
//  FilterModel.swift
//  O2OTest

//  Created by Luis Guerra on 10/7/21.
//

import Foundation

class FilterModel {
    var perPage: String = K.perPage
    var minIBU: String = K.minIBU
    var maxIBU: String = K.maxIBU
    var filterIBU: Bool = false
    var minABV: String = K.minABV
    var maxABV: String = K.maxABV
    var filterABV: Bool = false
    var filterString: String = ""
    
    init() {
        self.perPage = K.perPage
        self.minIBU = K.minIBU
        self.maxIBU = K.maxIBU
        self.minABV = K.minABV
        self.maxABV = K.maxABV
    }
    
    func updateFilterString() {
        let ibuFilter = filterIBU ? "&ibu_gt=\(self.minIBU)&ibu_lt=\(self.maxIBU)" : ""
        let abvFilter = filterABV ? "&abv_gt=\(self.minABV)&abv_lt=\(self.maxABV)" : ""
        self.filterString = ibuFilter+abvFilter
    }
    
}
