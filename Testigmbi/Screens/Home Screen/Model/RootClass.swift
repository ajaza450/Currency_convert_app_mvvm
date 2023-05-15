

import Foundation

struct RootClass : Codable {

	let listed : [Listed]?
	let message : String?
	let status : Int?


	enum CodingKeys: String, CodingKey {
		case listed = "listed"
		case message = "message"
		case status = "status"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		listed = try values.decodeIfPresent([Listed].self, forKey: .listed)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
	}


}
