//
//  SwiftUIView.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 26/12/24.
//

import SwiftUI
struct SearchResultPostsListView: View {
    @ObservedObject var datasource: SearchResultListViewModel<PostPreview.Presenter>
    
    var body: some View {
        SearchResultListView(datasource: datasource) {
            ForEach(datasource.presenters) { presenter in
                Post.PostPreview {
                    PostPreviewViewModel(preview: presenter.data,
                                         style: .medium,
                                         eventVitals: .init(metricsData: presenter.metricsData),
                                         layout: .list,
                                         sourceProvider: presenter.sourceProvider,
                                         onSelect: presenter.viewModel.onSelect)
                }
            }
        }
    }
}
#Preview {
    SearchResultPostsListView(datasource: SearchResultListViewModel() )
}
