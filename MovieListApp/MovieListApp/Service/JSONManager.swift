//
//  JSONManager.swift
//  MovieListApp
//
//  Created by Jyoti on 05/11/2022.
//

import Foundation

final class JSONManager {
    
    static let shared: JSONManager = {
        let instance = JSONManager()
        return instance
    }()
    
    func getDatafrom<T:Codable>(localJSON filename: String,
                     bundle: Bundle = .main, decodeToType type: T.Type, completionHandler: @escaping (Result<T,JSONParseError>) -> ()) {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            return completionHandler(.failure(.fileNotFound))
        }
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch let error {
            return completionHandler(.failure(.dataInitialization(error: error)))
        }
        do {
            let decodedResponse = try JSONDecoder().decode(type.self, from: data)
            print(decodedResponse)
            completionHandler(.success(decodedResponse))
        } catch let error {
            return completionHandler(.failure(.decoding(error: error)))
        }
    }
}
