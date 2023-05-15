//
//  EndPointType.swift
//  CurrnecyConvertTest
//
//  Created by EZAZ AHAMD on 04/03/23.
//

import Foundation

enum HTTPMethods: String {
    case post = "POST"
}

protocol EndPointType{
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: [String: String] { get }
    var default_param: [String: String] { get }
}
