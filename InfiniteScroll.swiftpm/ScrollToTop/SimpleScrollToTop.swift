//
//  SwiftUIView.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 27/12/24.
//

import SwiftUI

struct SimpleScrollToTop: View {
    @State var ReachTop = false
    let ReachTopVisible = 10
    @State var extractedExpr: ClosedRange<Int> = 0...120
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            List {
                ForEach(extractedExpr,id: \.self){ index in
                    VStack(){
                        AssetList.items[index % AssetList.items.count]
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text("\(index) Item number")
                        
                    }
                    .id(index)
                    .onAppear {
                        if index > ReachTopVisible {
                            ReachTop = true
                        }else{
                            ReachTop = false
                        }
                        extractedExpr = 0...50
                    }
                }
            }
            if ReachTop {
                HStack {
                    Button {
                        extractedExpr = 0...0
                    } label: {
                        Image(systemName: "chevron.up.2")
                            .foregroundStyle(.black)
                            .padding()
                            .background(.cyan.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }.padding(.trailing)
            }
        }
        
    }
}

#Preview {
    SimpleScrollToTop()
}
struct AssetList {
    static let items = [
        Image("IMG_0001"), Image("IMG_0002"), Image("IMG_0003"), Image("IMG_0004"), Image("IMG_0005"), Image("IMG_0006")
    ]
}
