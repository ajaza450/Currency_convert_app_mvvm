//
//  NetworkService.swift
//  Testigmbi
//
//  Created by EZAZ AHAMD on 09/02/23.
//

import Foundation



typealias Handler<T> = (Result<T, DataError>)-> Void

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}
final class NetworkService {
    
    static let shared = NetworkService()
    private init(){}
    
    func request<T: Codable>( type: EndPointType, modelType : T.Type, completion: @escaping Handler<T>){
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        var urlComponent = URLComponents(string: "\(url)")!
        let queryItems = type.body.map  { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponent.queryItems = queryItems
        
        //Now make `URLRequest` and set body and headers with it
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = type.method.rawValue
        if let query = urlComponent.url!.query {
            print("--> query: \(query)")
            request.httpBody = Data(query.utf8)
        }
        request.allHTTPHeaderFields = type.headers
        URLSession.shared.dataTask(with: request){ data, response, error in
           // print(response)
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let json =  try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(json))
            }catch {
                completion(.failure(.network(error)))
            }
        }.resume()
     }
    
    
}
