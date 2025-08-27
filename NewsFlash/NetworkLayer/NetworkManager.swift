//
//  NetworkManager.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Combine
import os.log
import Foundation

protocol NetworkManager {
    func performNetworkRequest(with requestData: RequestProtocol) -> AnyPublisher<Data, Error>
}

class DefaultNetworkManager: NetworkManager {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func performNetworkRequest(with requestData: RequestProtocol) -> AnyPublisher<Data, Error> {
        do {
            let request = try requestData.request()
            return urlSession.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw NetworkError.invalidServerResponse
                    }
                    return data
                }
                .handleEvents(receiveOutput: { _ in
                    self.logSuccess(request)
                }, receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.logError(request, error)
                    }
                })
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    private func logSuccess(_ request: URLRequest) {
        Logger.networking.info("""
            ✅ [\(200)] [\(request.httpMethod  ?? "")] \
            \(request, privacy: .private)
            """)
    }
    
    private func logError(_ request: URLRequest, _ error: Error) {
        Logger.networking.error("""
            🛑 [Error] [\(request.httpMethod  ?? "")] \
            \(request, privacy: .private)
            Error Type: \(error.localizedDescription)
            """)
    }
}
