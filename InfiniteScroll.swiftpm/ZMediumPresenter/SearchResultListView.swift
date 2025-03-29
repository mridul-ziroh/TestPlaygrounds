//
//  SearchResultListView.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 26/12/24.
//
import SwiftUI

struct SearchResultListView<Presenter, Content: View>: View {
  @ObservedObject var datasource: SearchResultListViewModel<Presenter>
  var itemsView: () -> Content

  var body: some View {
      switch datasource.state {
    case .loading:
      loadingView
    case let .empty(message):
      makeMessageView(message)
    default:
      contentView
    }
  }

  private var loadingView: some View {
    MediumProgressView()
  }

  private func makeMessageView(_ message: String) -> some View {
    Text(message)
          .foregroundStyle(.red)
  }

  private var contentView: some View {
    List {
      itemsView()
      switch datasource.state {
      case .loadingNextPage:
        MediumProgressView()
      case .data, .nextPageData:
        MediumProgressView()
          .onAppear {
//            Task { await datasource.fetchNextPage() }
          }
      default:
        EmptyView()
      }
    }
    .scrollDismissesKeyboard(.immediately)
    .scrollContentBackground(.hidden)
    .listStyle(.plain)
  }
}
