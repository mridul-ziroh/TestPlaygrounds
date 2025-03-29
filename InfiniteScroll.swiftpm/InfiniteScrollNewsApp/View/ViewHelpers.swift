//
//  ViewHelpers.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 27/12/24.
//
import SwiftUI

struct LoadingProgressView: View {
    var body: some View {
        ProgressView()
            .foregroundStyle(Color.gray)
            .scaleEffect(1.5)
            .progressViewStyle(CircularProgressViewStyle())
    }
}
