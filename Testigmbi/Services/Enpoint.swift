//
//  Enpoints.swift
//  Testigmbi
//
//  Created by EZAZ AHAMD on 09/02/23.
//

import Foundation

enum BookingEndPoint {
    case getResult(param:[String: String])
}


extension BookingEndPoint : EndPointType{
    var path: String {
        switch self {
        case .getResult:
            return "/search_table"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var baseURL: String {
        return "https://igmiweb.com/gladdenhub/Api"
        
    }
    
    var method: HTTPMethods {
        switch self {
        case .getResult:
            return .post
        }
    }
    
    var body: [String: String] {
        switch self {
        case .getResult(let param):
            return param
        }
    }
    
    var headers: [String : String]? {
        return commonHeaders
    }
    
    
}
