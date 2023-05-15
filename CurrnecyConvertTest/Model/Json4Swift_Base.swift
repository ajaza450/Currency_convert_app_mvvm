
import Foundation
struct Json_Base : Codable {
	let base : String?
	let rates : Rates?

	enum CodingKeys: String, CodingKey {
        case base = "base"
		case rates = "rates"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		base = try values.decodeIfPresent(String.self, forKey: .base)
		rates = try values.decodeIfPresent(Rates.self, forKey: .rates)
	}

}



struct Currency: Codable {
    let rate: Double?
    let name: String
}



struct Conversion {
    let currency: Currency
    var amount: Double?
}
