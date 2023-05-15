
import Foundation

struct TimeAvailable : Codable {

	let time : String?


	enum CodingKeys: String, CodingKey {
		case time = "time"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		time = try values.decodeIfPresent(String.self, forKey: .time)
	}


}
