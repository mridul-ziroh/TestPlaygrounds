//
//  Helpers.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 27/12/24.
//
import Foundation

struct EverythingRequest{
    var query: String?
    var pageSize: String?
    var page: String?
    
    func toQueryItems() -> [URLQueryItem] {
        [
            ("q", query),
            ("pageSize", pageSize),
            ("page", page)
        ].compactMap { name, value in
            value.map { URLQueryItem(name: name, value: $0) }
        }
    }
}

struct ApiResult: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Hashable {
    let source: Source
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
    
    
    // Implementing the hash(into:) method
    func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(author)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(url)
        hasher.combine(urlToImage)
        hasher.combine(publishedAt)
        hasher.combine(content)
    }

    // Equatable conformance is automatically derived when Hashable is implemented
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.source == rhs.source &&
            lhs.author == rhs.author &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.url == rhs.url &&
            lhs.urlToImage == rhs.urlToImage &&
            lhs.publishedAt == rhs.publishedAt &&
            lhs.content == rhs.content
    }
}

func DefaultArticle() -> Article {
    Article(source: Source(id: nil, name: "Default"),
            author: nil,
            title: "Not found",
            description: "Default",
            url: "Default", urlToImage: "Default", publishedAt: Date.now, content: "Default")
}

// MARK: - Source
struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
