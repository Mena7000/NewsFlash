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
        startObserving()
    }

    func startObserving() {
        $selectedCountry
            .compactMap { $0 }
            .sink { [weak self] country in
                guard let self = self else { return }
                print("Selected country is: \(country.name)")
                news.removeAll()
                fetchNews(country: country.value)
            }
            .store(in: &cancellables)
        
        $searchKeyword
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] keyword in
                guard let self = self else { return }
                print("search keyword is: \(keyword)")
                news.removeAll()
                fetchNews(q: keyword)
            }
            .store(in: &cancellables)
    }
    
    func fetchNews(country: String = "", q: String = "") {
        isLoading = true
        var currentPage = 0
        if news.count != 0 {
            currentPage = (news.count / 10)
        }

        var selectedCountryValue = "eg"
        if country != "" {
            selectedCountryValue = country
        } else if selectedCountry != nil {
            selectedCountryValue = selectedCountry?.value ?? "eg"
        }
        
        var keyword = ""
        if q != "" {
            keyword = q
        } else if searchKeyword != "" {
            keyword = searchKeyword
        }
        
        topHeadlinesListUseCase.fetchTopHeadlines(country: selectedCountryValue,
                                                  q: keyword,
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
