//
//  NetworkError.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation

public enum NetworkError: LocalizedError {
    case noInternet
    case invalidServerResponse
    case invalidURL
    case unknown
    case decodingError(DecodingError?)
    case httpError(statusCode: Int, message: String?)

    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection. Please check your network."
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL string is malformed."
        case .unknown:
            return "unknown"
        case .decodingError(let decodingError):
            return "Decoding error: \(decodingError)"
        case .httpError(let statusCode, let message):
            switch statusCode {
            case 400:
                return message ?? "Bad request. Please try again."
            case 401:
                return "Unauthorized. Please login again."
            case 403:
                return "You don’t have permission to perform this action."
            case 404:
                return "The resource was not found."
            case 500...599:
                return "Server error. Please try later."
            default:
                return message ?? "Unexpected error (\(statusCode))."
            }
        }
    }
}
