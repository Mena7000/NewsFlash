//
//  EmptyViewState.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/28/25.
//

enum EmptyViewState {
    case noInternet
    case noResults
    case hidden

    public var imgName: String {
        switch self {
        case .noInternet: return "noInternet_ic"
        case .noResults: return "emptyList_ic"
        case .hidden: return ""
        }
    }
    
    public var title: String {
        switch self {
        case .noInternet: return "No internet connection."
        case .noResults: return "No Results"
        case .hidden: return ""
        }
    }
    
    public var disc: String {
        switch self {
        case .noInternet: return "Please check your network."
        case .noResults: return "Your current search did not yield any results."
        case .hidden: return ""
        }
    }
}
