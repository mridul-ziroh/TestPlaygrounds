//
//  Post.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 26/12/24.
//
import SwiftUI

struct Post {
    struct PostPreview: View {
        @StateObject var viewModel: PostPreviewViewModel
        public init(viewModel: @escaping () -> PostPreviewViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel())
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Image(systemName: "bolt")
                Text(viewModel.preview.title)
                    .font(.headline)
                Text(viewModel.preview.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Text("Likes: \(viewModel.eventVitals.metricsData.likes)")
                    Text("Comments: \(viewModel.eventVitals.metricsData.comments)")
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding()
            .onTapGesture {
                viewModel.onSelect()
            }
        }
    }
}
