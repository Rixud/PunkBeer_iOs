//
//  BeerModel.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import Foundation


struct BeerModel: Codable {
    var id: Int?
    var name: String?
    var tagLine: String?
    var first_brewed: String?
    var description: String?
    var image_url: String?
    var abv: Double?
    var ibu: Double?
    var target_fg: Double?
    var target_og: Double?
    var ebc: Double?
    var srm: Double?
    var ph: Double?
    var attenuation_level: Double?
    var volume: MetricModel?
    var boil_volume: MetricModel?
    var method: MethodModel?
    var ingredients: IngredientModel?
    var food_pairing: [String]?
    var brewers_tips: String?
    var contributed_by: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case tagLine = "tagline"
        case first_brewed = "first_brewed"
        case description = "description"
        case image_url = "image_url"
        case abv = "abv"
        case ibu = "ibu"
        case target_fg = "target_fg"
        case target_og = "target_og"
        case ebc = "ebc"
        case srm = "srm"
        case ph = "ph"
        case attenuation_level = "attenuation_level"
        case volume = "volume"
        case boil_volume = "boil_volume"
        case method = "method"
        case ingredients = "ingredients"
        case food_pairing = "food_pairing"
        case brewers_tips = "brewers_tips"
        case contributed_by = "contributed_by"

    }
    
}
