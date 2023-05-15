//
//  EndPointType.swift
//  Testigmbi
//
//  Created by EZAZ AHAMD on 09/02/23.
//

import Foundation

enum HTTPMethods: String {
    case post = "POST"
}

protocol EndPointType{
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: [String: String] { get }
    var headers: [String: String]? { get }
}
