//
//  ApiManager.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import Foundation


class ApiFunk {
    var stringURL:String = K.staticUrl
    var beerList : [BeerModel]?
    
    
    func callApi(filterString:String, completionHandler: @escaping ([BeerModel]?, Error?) -> Void) {
        let url = URL(string: stringURL+filterString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

        guard let data = data else { return }
        do {
        self.beerList = try? JSONDecoder().decode([BeerModel].self, from: data)
          if let beerList = self.beerList {
            completionHandler(beerList, nil)
          }
          
        } catch let parseErr {
          print("JSON Parsing Error", parseErr)
            completionHandler(nil, parseErr)
        }
      })
      
      task.resume()
    }
    
    
    func updateURLWithSearchBar (searchStr:String, perPage:String) {
        let strWithoutSpaces = searchStr.replacingOccurrences(of: " ", with: "_")
        stringURL = K.staticUrl+"food="+strWithoutSpaces+"&per_page="+perPage
    }
    
    func updateURLWithPage(page:String, lastSearch:String, perPage:String) {
        if lastSearch.count != 0 {
            stringURL = K.staticUrl+"food="+lastSearch+"&page="+page+"&per_page="+perPage
        } else {
            stringURL = K.staticUrl+"page="+page+"&per_page="+perPage
        }
    }
    
    func updateURLWithId(id:String) {
        stringURL = K.staticUrl.replacingOccurrences(of: "?", with: "/")+id
    }

    
    func resetURL () {
        stringURL = K.staticUrl
    }
}

var Api = ApiFunk()
