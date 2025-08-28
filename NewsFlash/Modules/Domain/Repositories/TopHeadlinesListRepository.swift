//
//  TopHeadlineListRepository.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import Combine
import Foundation

protocol TopHeadlinesListRepository {
    func fetchTopHeadlinesList(country: String, q: String, page: Int) -> AnyPublisher<TopHeadlinesResponse, NetworkError>
}

final class DefaultTopHeadlinesListRepository: TopHeadlinesListRepository {
    private let requestManager: RequestManager

    init(requestManager: RequestManager = DefaultRequestManager()) {
        self.requestManager = requestManager
    }

//    top-headlines?category=general&apikey=66a30fb20f96f51ad9858c6c3b52b52d
    func fetchTopHeadlinesList(country: String, q: String, page: Int) -> AnyPublisher<TopHeadlinesResponse, NetworkError> {
        let request = DefaultRequest(
            path: (q == "") ? "top-headlines" : "search",
            requestType: .GET,
            urlParams: [
                "apikey": APIConstants.apiKey,
                "category": "general",
                "page": "\(page)",
                "q": "\(q)",
                "country": "\(country)"
            ]
        )

        return requestManager.performRequest(with: request)
            .decode(type: TopHeadlinesResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                }
                return error as? NetworkError ?? .unknown
            }
            .eraseToAnyPublisher()
    }
}

