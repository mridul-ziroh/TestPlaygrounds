//
//  Untitled.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 26/12/24.
//
import SwiftUI
import Foundation

enum SearchResultListState {
    case loading
    case loadingNextPage
    case data
    case nextPageData
    case empty(String)
    case error(String)
}

struct MediumProgressView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
            .progressViewStyle(CircularProgressViewStyle())
    }
}



struct PostPreview {
    struct Presenter: Identifiable {
        let id: UUID
        let data: PostData
        let metricsData: MetricsData
        let sourceProvider: String
        let viewModel: PostPreviewViewModel
    }
}

struct PostData {
    let title: String
    let description: String
}

struct MetricsData {
    let likes: Int
    let comments: Int
}

class PostPreviewViewModel: ObservableObject {
    let preview: PostData
    let style: PreviewStyle
    let eventVitals: EventVitals
    let layout: LayoutStyle
    let sourceProvider: String
    let onSelect: () -> Void

    init(preview: PostData,
         style: PreviewStyle,
         eventVitals: EventVitals,
         layout: LayoutStyle,
         sourceProvider: String,
         onSelect: @escaping () -> Void) {
        self.preview = preview
        self.style = style
        self.eventVitals = eventVitals
        self.layout = layout
        self.sourceProvider = sourceProvider
        self.onSelect = onSelect
    }
}

enum PreviewStyle {
    case small
    case medium
    case large
}

struct EventVitals {
    let metricsData: MetricsData
}

enum LayoutStyle {
    case list
    case grid
}
