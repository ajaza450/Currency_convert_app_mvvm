
import Foundation

struct Listed : Codable {
    let business_name : String?
    let image : String?
    let rating : String?
    let id : String?
    let address : String?
    let description : String?
    let restaurant_type : [RestaurantType]?
    let time_available : [TimeAvailable]?
    let seat_available : String?
    let get_time : String?
    let service_provider : String?
 
}
