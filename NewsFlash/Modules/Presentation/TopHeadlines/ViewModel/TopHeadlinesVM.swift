//
//  TopHeadlinesVM.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation
import Combine

class TopHeadlinesVM: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var error: NetworkError?
    var cancellables = Set<AnyCancellable>()
   
    @Published var searchKeyword: String = ""
   
    private let topHeadlinesListUseCase: TopHeadlinesListUseCase

    @Published var news: [Article] = []
    
    var countiesArray: [Country] = LoadCountiesUtil.loadCountries()
    @Published var selectedCountry: Country? = nil
    
    
    init(topHeadlinesListUseCase: TopHeadlinesListUseCase) {
        self.topHeadlinesListUseCase = topHeadlinesListUseCase
    }

    func fetchNews() {
        isLoading = true
        var currentPage = 0
        if news.count != 0 {
            currentPage = (news.count / 10)
        }

        topHeadlinesListUseCase.fetchTopHeadlines(page: (currentPage + 1))
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("News fetching completed")
                case .failure(let error):
                    self.error = error
                    print("Failed to fetch News: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                self.news.append(contentsOf: response.articles ?? [])
//                self.currentPage = response.page ?? 1
//                self.totalPages = response.totalPages ?? 1
            }
            .store(in: &cancellables)
    }
    
    func fetchNextPage(indxRow: Int) {
//        let totalCount = news.count
//        if totalCount != 0  {
//            if totalCount&& !isLoading {
//                fetchNews()
//            }
//        }
    }

    deinit {
        print("💰💰💰💰 TopHeadlinesVM deallocated 💰💰💰💰")
    }
}
