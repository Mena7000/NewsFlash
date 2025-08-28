//
//  NetworkError.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case invalidURL
    case badRequest
    case unauthorized
    case forbidden
    case tooManyRequests
    case internalServerError
    case serviceUnavailable
    case invalidServerResponse
    case decodingError(DecodingError)
    case unknown

    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection. Please check your network."
        case .invalidURL:
            return "URL string is malformed."
        case .badRequest:
            return "The request was malformed, often due to missing or invalid parameters"
        case .unauthorized:
            return "No valid API key provided or API key is invalid"
        case .forbidden:
            return "You have reached your daily quota limit, the next reset is at 00:00 UTC"
        case .tooManyRequests:
            return "Too many requests were sent in a short time period"
        case .internalServerError:
            return "Something went wrong on our end"
        case .serviceUnavailable:
            return "We're temporarily offline for maintenance"
        case .invalidServerResponse:
            return "Invalid server response"
        case .decodingError(let err):
            return "Failed to decode response: \(err.localizedDescription)"
        case .unknown:
            return "An unknown error occurred."
        }
    }

    static func fromStatusCode(_ code: Int) -> NetworkError {
        switch code {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 429:
            return .tooManyRequests
        case 500:
            return .internalServerError
        case 503:
            return .serviceUnavailable
        default:
            return .unknown
        }
    }
}
