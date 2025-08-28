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
        observeCountryFilter()
    }

    func observeCountryFilter() {
        $selectedCountry
            .compactMap { $0 }
            .sink { [weak self] country in
                guard let self = self else { return }
                print("Selected country is: \(country.name)")
                news.removeAll()
                fetchNews(selectedCountry: country.value)
            }
            .store(in: &cancellables)
    }
    
    func fetchNews(selectedCountry: String = "eg") {
        isLoading = true
        var currentPage = 0
        if news.count != 0 {
            currentPage = (news.count / 10)
        }

        topHeadlinesListUseCase.fetchTopHeadlines(country: selectedCountry,
                                                  page: (currentPage + 1))
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
        let totalCount = news.count
        if totalCount != 0  {
            let currentPage = (totalCount / 10)
            
            if (indxRow + 1) == (currentPage * 10) && !isLoading {
                fetchNews()
            }
        }
    }

    deinit {
        print("💰💰💰💰 TopHeadlinesVM deallocated 💰💰💰💰")
    }
}
