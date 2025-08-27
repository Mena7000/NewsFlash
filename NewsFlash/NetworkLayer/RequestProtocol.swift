//
//  RequestProtocol.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation
import OSLog

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
    
    var host: String {
       return APIConstants.baseURL
    }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }

    func request() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path

        var queryParamsList: [URLQueryItem] = []
        queryParamsList.append(contentsOf: urlParams.compactMap { URLQueryItem(name: $0.key, value: $0.value) })

        components.queryItems = queryParamsList

        guard let url = components.url else {
            print("Invalid URL components: \(components)")
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("Bearer \(APIConstants.token)", forHTTPHeaderField: "Authorization")

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        Logger.networking.info("🚀 [REQUEST] [\(requestType.rawValue)] \(urlRequest, privacy: .private)")

        return urlRequest
    }
}

struct DefaultRequest: RequestProtocol {
    let path: String
    let requestType: RequestType
    let urlParams: [String: String?]

    init(path: String, requestType: RequestType, urlParams: [String: String?]) {
        self.path = path
        self.requestType = requestType
        self.urlParams = urlParams
    }
}
