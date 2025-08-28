//
//  TopHeadlinesListService.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import Combine
import Foundation

protocol TopHeadlinesListServiceProtocol {
    func fetchTopHeadlines(country: String, q: String, page: Int) -> AnyPublisher<TopHeadlinesResponse, NetworkError>
}

class TopHeadlinesListService: TopHeadlinesListServiceProtocol {
    private let requestManager: RequestManager

    init(requestManager: RequestManager = DefaultRequestManager()) {
        self.requestManager = requestManager
    }

    func fetchTopHeadlines(country: String, q: String, page: Int) -> AnyPublisher<TopHeadlinesResponse, NetworkError> {
        let request = DefaultRequest(
            path: (q == "") ? "top-headlines" : "search",
            requestType: .GET,
            urlParams: [
                "category": "general",
                "apikey": APIConstants.apiKey,
                "page": "\(page)",
                "q": "\(q)",
                "country": "\(country)"
            ]
        )

        return requestManager.performRequest(with: request)
            .decode(type: TopHeadlinesResponse.self, decoder: JSONDecoder()) // parse inside service
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                }
                return error as? NetworkError ?? .unknown
            }
            .eraseToAnyPublisher()
    }
}
