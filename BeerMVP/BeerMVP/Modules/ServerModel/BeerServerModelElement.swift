// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let beerServerModel = try? newJSONDecoder().decode(BeerServerModel.self, from: jsonData)

import Foundation

// MARK: - BeerServerModelElement
struct BeerServerModelElement: Decodable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let beerServerModelDescription: String
    let imageurl: String
    let abv: Double
    let ibu: Double?
    let targetFg: Int
    let targetOg: Double
    let ebc: Int?
    let srm: Double?
    let ph: Double?
    let attenuationLevel: Double
    let volume: Volume
    let boilVolume: Volume
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: ContributedBy

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case tagline = "tagline"
        case firstBrewed = "first_brewed"
        case beerServerModelDescription = "description"
        case imageurl = "image_url"
        case abv = "abv"
        case ibu = "ibu"
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc = "ebc"
        case srm = "srm"
        case ph = "ph"
        case attenuationLevel = "attenuation_level"
        case volume = "volume"
        case boilVolume = "boil_volume"
        case method = "method"
        case ingredients = "ingredients"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

// MARK: - Volume
struct Volume: Decodable {
    let value: Int
    let unit: BoilVolumeUnit

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"
    }
}

enum BoilVolumeUnit: String, Decodable {
    case litres = "litres"
}

enum ContributedBy: String, Decodable {
    case aliSkinnerAliSkinner = "Ali Skinner <AliSkinner>"
    case samMasonSamjbmason = "Sam Mason <samjbmason>"
}

// MARK: - Ingredients
struct Ingredients: Decodable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String

    enum CodingKeys: String, CodingKey {
        case malt = "malt"
        case hops = "hops"
        case yeast = "yeast"
    }
}

// MARK: - Hop
struct Hop: Decodable {
    let name: String
    let amount: HopAmount
    let add: Add
    let attribute: Attribute

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
        case add = "add"
        case attribute = "attribute"
    }
}

enum Add: String, Decodable {
    case dryHop = "dry hop"
    case end = "end"
    case middle = "middle"
    case start = "start"
}

// MARK: - HopAmount
struct HopAmount: Decodable {
    let value: Double
    let unit: PurpleUnit

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"
    }
}

enum PurpleUnit: String, Decodable {
    case grams = "grams"
}

enum Attribute: String, Decodable {
    case aroma = "aroma"
    case attributeFlavour = "Flavour"
    case bitter = "bitter"
    case flavour = "flavour"
}

// MARK: - Malt
struct Malt: Decodable {
    let name: String
    let amount: MaltAmount

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
    }
}

// MARK: - MaltAmount
struct MaltAmount: Decodable {
    let value: Double
    let unit: FluffyUnit

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"
    }
}

enum FluffyUnit: String, Decodable {
    case kilograms = "kilograms"
}

// MARK: - Method
struct Method: Decodable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation = "fermentation"
        case twist = "twist"
    }
}

// MARK: - Fermentation
struct Fermentation: Decodable {
    let temp: Temp

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}

// MARK: - Temp
struct Temp: Decodable {
    let value: Int
    let unit: TempUnit

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"
    }
}

enum TempUnit: String, Decodable {
    case celsius = "celsius"
}

// MARK: - MashTemp
struct MashTemp: Decodable {
    let temp: Temp
    let duration: Int?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case duration = "duration"
    }
}

typealias BeerServerModel = [BeerServerModelElement]
