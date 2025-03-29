//
//  QuizNetworkApi.swift
//  App
//
//  Created by mridul-ziroh on 21/03/25.
//
import Foundation
import Combine

struct Quiz: Codable, Identifiable {
    var id: Int
    var question: String
    var options: [String]
    var answer: String
    var selectedOption: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case options
        case answer
    }
}

struct QuizNetworkApi {
   static let shared = QuizNetworkApi()
    
    func fetchQuizzes() -> AnyPublisher<[Quiz], Never>  {
        guard let url = URL(string: "https://my-json-server.typicode.com/ashutoshbilla/demo/questions") else
        { return Just([]).eraseToAnyPublisher()}
        
         return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Quiz].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

