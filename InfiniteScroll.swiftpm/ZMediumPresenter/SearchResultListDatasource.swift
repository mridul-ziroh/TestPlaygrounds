//
//  SearchResultListDatasource.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 26/12/24.
//

import Foundation
import Combine

class SearchResultListViewModel<Presenter>: ObservableObject {
    @Published var state: SearchResultListState = .error("Nothing")
    @Published var presenters: [Presenter] = []
    private var currentPage: Int = 0
    private var isFetching: Bool = true

    func fetchNextPage() async {
        guard !isFetching else { return }
        isFetching = true
        state = .loadingNextPage

        // Simulate fetching data
        do {
            let newPresenters = try await fetchData(for: currentPage + 1)
            DispatchQueue.main.async {
//                self.presenters.append(contentsOf: newPresenters)
//                self.currentPage += 1
//                self.state = .data
            }
        } catch {
            DispatchQueue.main.async {
//                self.state = .error("Failed to load data.")
            }
        }
        isFetching = false
    }

    private func fetchData(for page: Int) async throws -> [Presenter] {
        // Simulated data fetching logic, replace with actual implementation.
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate delay
        return  [

        ] // Replace with fetched data
    }
}
