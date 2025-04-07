//
//  Api.swift
//  App
//
//  Created by mridul-ziroh on 20/03/25.
//
//{
//"username": "user1",
//"avatar": "https://robohash.org/user1.png"
//}
import Foundation

struct User: Codable, Identifiable {
    let id = UUID()
    var username: String
    var avatar: String
    var favourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case username
        case avatar
    }
}

class UsersNetworkApi {
    static let shared :UsersNetworkApi = UsersNetworkApi()
    
    func fetchData() async throws -> [User] {
        guard let url = URL(string: "https://my-json-server.typicode.com/ashutoshbilla/demo/users") else {
            return []
        }
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            print(error)
        }
        return []
    }
}
