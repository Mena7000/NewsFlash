//
//  TopHeadlinesListUseCase.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import Combine

protocol TopHeadlinesListUseCase {
    func fetchTopHeadlines(country: String, page: Int) -> AnyPublisher<TopHeadlinesResponse, NetworkError>
}

class DefaultTopHeadlinesListUseCase: TopHeadlinesListUseCase {
    private let repository: TopHeadlinesListRepository
    
    init(repository: TopHeadlinesListRepository) {
        self.repository = repository
    }
    
    func fetchTopHeadlines(country: String, page: Int) -> AnyPublisher<TopHeadlinesResponse, NetworkError> {
        repository.fetchTopHeadlinesList(country: country, page: page)
    }
}
