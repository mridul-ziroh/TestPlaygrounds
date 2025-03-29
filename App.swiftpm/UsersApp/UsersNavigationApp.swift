//
//  ContentView.swift
//  App
//
//  Created by mridul-ziroh on 20/08/24.
//

import SwiftUI

struct UsersNavigationApp: View {
    @StateObject private var viewModel = USerViewModel()
    
    var body: some View {
        VStack{
            NavigationStack{
                List($viewModel.users, id: \.username){ user in
                    NavigationLink {
                        VStack{
                            image(user.avatar.wrappedValue)
                            Text(user.username.wrappedValue)
                            Button {
                                viewModel.addFav(user.wrappedValue)
                            } label: {
                                Image(systemName: "star")
                                    .padding()
                            }
                        }
                    } label: {
                        HStack{
                            image(user.avatar.wrappedValue)
                            Text(user.username.wrappedValue)
                            Spacer()
                            if user.wrappedValue.favourite {
                                Image(systemName: "star")
                                    .foregroundStyle(.yellow)
                            }
                        }
                    }
                }
                .navigationTitle("Users")
            }
        }.task {
            await viewModel.fetchUsers()
        }
    }
    
    func image(_ url: String) -> some View {
        AsyncImage(url: URL(string: url)!){ image in
            image
                .resizable()
                .frame(width:40, height: 40)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
}

#Preview {
    UsersNavigationApp()
}
