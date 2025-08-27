//
//  RequestManager.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation
import Combine

// MARK: - Request Manager Protocol -
protocol RequestManager {
    func performRequest(with request: RequestProtocol) -> AnyPublisher<Data, NetworkError>
}

final class DefaultRequestManager: RequestManager {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }

    func performRequest(with request: RequestProtocol) -> AnyPublisher<Data, NetworkError> {
        return networkManager.performNetworkRequest(with: request)
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Returns Data Parser -
extension RequestManager {
    var parser: DataParser {
        return DefaultDataParser()
    }
}
