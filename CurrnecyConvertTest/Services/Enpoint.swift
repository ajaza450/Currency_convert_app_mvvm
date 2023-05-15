//
//  Enpoints.swift
//  CurrnecyConvertTest
//
//  Created by EZAZ AHAMD on 04/03/23.
//

import Foundation

enum ExchangerateEndPoint {
    case get_latest_rate
    
}


extension ExchangerateEndPoint : EndPointType{
    var default_param: [String : String] {
        return ["app_id":"79f8074e6bc34a6da6741ec26dcf08e0"]
    }
    
   
    
    var url: URL? {
        return URL(string: "\(baseURL)")
    }
    
    var baseURL: String {
        return "https://openexchangerates.org/api/latest.json"
        
    }
    
    var method: HTTPMethods {
        switch self {
        case .get_latest_rate:
            return .post
        }
    }
    
    var body: [String: String] {
        switch self {
        case .get_latest_rate:
            return [String: String]()
        }
    }
    
    
    
    
}
