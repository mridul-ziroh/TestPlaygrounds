//
//  ModelHelpers.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 27/12/24.
//

enum ViewModelState {
    case loading
    case loadingNextPage
    case data
    case nextPageData
    case empty(String)
    case error(String)
}
