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
    private let service: TopHeadlinesListServiceProtocol

    init(service: TopHeadlinesListServiceProtocol) {
        self.service = service
    }

    func fetchTopHeadlinesList(country: String, q: String, page: Int) -> AnyPublisher<TopHeadlinesResponse, NetworkError> {
        service.fetchTopHeadlines(country: country, q: q, page: page)
    }
}
