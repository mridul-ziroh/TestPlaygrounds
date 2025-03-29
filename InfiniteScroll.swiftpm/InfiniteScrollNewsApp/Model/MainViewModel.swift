//
//  MainViewModel.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 27/12/24.
//
import Foundation
@MainActor
class MainViewModel : ObservableObject
{
    @Published var state: ViewModelState = .loading
    @Published var articles: [Article] = []
    var page = 1
    func fetchArticles() async
    {
        let parameters = EverythingRequest(query: "bitcoin", pageSize: "10", page: "1")
        let Articles = await GetEverything(parameters) ?? [DefaultArticle()]
        state = .data
        articles.append(contentsOf: Articles)
    }
    func fetchNextArticles() async {
        state = .loadingNextPage
        page+=1
        print("Page number: \(page)")
        let parameters = EverythingRequest(query: "bitcoin", pageSize: "10", page: "\(page)")
        let Articles = await GetEverything(parameters) ?? [DefaultArticle()]
        state = .nextPageData	
        articles.append(contentsOf: Articles)
    }
    
}
