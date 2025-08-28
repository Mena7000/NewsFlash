//
//  DataParser.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation

protocol DataParser {
    func parse<T: Decodable>(data: Data) throws -> T
}

final class DefaultDataParser: DataParser {
    
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func parse<T: Decodable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
