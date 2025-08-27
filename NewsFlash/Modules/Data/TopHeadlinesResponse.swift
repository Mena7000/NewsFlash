//
//  TopHeadlinesResponse.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import Foundation

// MARK: - Top-level response
struct TopHeadlinesResponse: Codable {
    let totalArticles: Int?
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case totalArticles
        case articles
    }
}

// MARK: - Article
struct Article: Codable {
    let id: String?
    let title: String?
    let description: String?
    let content: String?
    let url: String?
    let image: String?
    let publishedAt: String?
    let lang: String?
    let source: Source?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, content, url, image
        case publishedAt
        case lang, source
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
    let url: String?
    let country: String?
}
