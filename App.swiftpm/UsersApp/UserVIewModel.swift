//
//  UserVIewModel.swift
//  App
//
//  Created by mridul-ziroh on 20/03/25.
//
import Foundation

class USerViewModel: ObservableObject {
    //if favourite persist use userdefaults
    init(){
        
    }
    let networkService = UsersNetworkApi.shared
    @Published var users: [User] = []
    
    func fetchUsers() async {
        let userList  = await networkService.fetchData()
        users += userList
    }
    
    func addFav(_ user: User) -> Void {
       let idx =  users.firstIndex(where: {$0.id == user.id})
        if let idx = idx {
            users[idx].favourite.toggle()
        }
    }
}
