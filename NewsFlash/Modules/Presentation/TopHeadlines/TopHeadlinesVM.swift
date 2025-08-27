//
//  TopHeadlinesVM.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation
import Combine

class TopHeadlinesVM: ObservableObject {
//    @Published var news: [News] = []
    @Published var isLoading: Bool = false
//    @Published var error: NetworkError?
   
    @Published var searchKeyword: String = ""

    var cancellables = Set<AnyCancellable>()

    deinit {
        print("💰💰💰💰 TopHeadlinesVM deallocated 💰💰💰💰")
    }

}
