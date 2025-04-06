//
//  NetworkError.swift
//  App
//
//  Created by mridul-ziroh on 06/04/25.
//


//
//  NetworkService.swift
//  ICC Cricket World Cup 2019
//
//  Created by mridul-ziroh on 06/04/25.
//
import Foundation
enum NetworkError : Error {
    case invalidURL
    case requestError(Int)
    case decodingError
    
}
protocol NetworkService {
    func fetchData<T: Decodable & Sendable>(from url: String) async throws -> [T]
}

struct MockedNetworkService : NetworkService {
    static let shared = MockedNetworkService()
    
    func fetchData<T: Decodable & Sendable >(from url: String = "nonExisting") async throws -> [T]{
        guard url.isEmpty == false else {
            throw NetworkError.invalidURL
        }
        //check for success response
        guard let data = JsonString.teamList.data(using: .utf8) else {
            let responseCode = 404
            throw NetworkError.requestError(responseCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode([T].self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    
}
