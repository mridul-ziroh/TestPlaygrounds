//
//  File.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 27/12/24.
//

import Foundation
let apiKey = "266e46125c1a468ea740d61265a748d2"
let baseURL = URL(string: "https://newsapi.org/v2/everything")!

func GetEverything(_ parameters:EverythingRequest) async -> [Article]? {
    
    var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
    urlComponents?.queryItems = parameters.toQueryItems()
    urlComponents?.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))
    
    // Construct the final URL
    guard let url = urlComponents?.url else {
        print("Failed to construct URL")
        return nil
    }
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
//        print(String(data: data, encoding: .utf8) ?? "Invalid response data")
        
        guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse) // Throw an error if casting fails
            }
        
            // Validate the status code
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(httpResponse.statusCode)")
                throw URLError(.init(rawValue: httpResponse.statusCode)) // Or create a custom error
            }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let apiResult = try decoder.decode(ApiResult.self, from: data)
        
        print("Status: \(apiResult.status)")
        print("Total Results: \(apiResult.totalResults)")
        for article in apiResult.articles {
            print("Article Title: \(article.title)")
        }
        return apiResult.articles
        
    } catch {
        print("Failed to fetch or decode data: \(error.localizedDescription)")
        return nil
    }
}
