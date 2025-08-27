//
//  DependencyContainer.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation
class DependencyContainer {
    static let shared = DependencyContainer()

    private init() {}

    func resolveTopHeadlinesListUseCase() -> TopHeadlinesListUseCase {
        let repository = DefaultTopHeadlinesListRepository(requestManager: DefaultRequestManager())
        return DefaultTopHeadlinesListUseCase(repository: repository)
    }
}
