//
//  AviatorView.swift
//  App
//
//  Created by mridul-ziroh on 29/03/25.
//

import SwiftUI
import Foundation

struct AviatorView : View {
    @StateObject var viewModel = AviatorViewModel()
    var body: some View {
        VStack {
            Text("Aviator")
                .font(.largeTitle)
            HStack {
                Text("Money")
                Spacer()
                Text("$\(viewModel.total, specifier: "%.2f")")
            }
            .padding(.horizontal,40)
            Text("\(viewModel.multiplier, specifier: "%.2f")")
                .font(.largeTitle)
                .animation(.default)
            Image(systemName: "paperplane")
                .resizable()
                .frame(width: 40, height: 40)
            Button {
                    viewModel.startMultiplier()
            } label: {
                Text("Start \(viewModel.multiplier * 100, specifier: "%.2f")")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(20)
                    .background(viewModel.isInvalid ? .red : .green)
                    .cornerRadius(20)
                
            }
            
        }
    
    }
}

#Preview {
    AviatorView()
}
