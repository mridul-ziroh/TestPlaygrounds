//
//  CameraView.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 12/03/25.
//


//
//  SwiftUIView.swift
//  App
//
//  Created by mridul-ziroh on 09/10/24.
//

import SwiftUI

struct CameraView: View {
    
    @State private var exposureIndex: Int? = 0
    var exposureConstants = [-2.0, -1.7, -1.3, -1.0, -0.7, -0.3, 0.0, 0.3, 0.7, 1.0, 1.3, 1.7, 2.0 ]
    var body: some View {
        ZStack {
            Color.black
            ZStack{
                if #available(iOS 17.0, *){
                    //                                        ScrollForExposureCompat
                    
                    ScrollForExposure
                } else {
                    ScrollForExposureCompat
                }
            }
            .foregroundStyle(.white)
        }
    }
    
    @available(iOS 17.0, *)
    var ScrollForExposure: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0){
                ForEach(exposureConstants.indices, id: \.self) { index in
                    let indexDiff = Double(index - (exposureIndex ?? 0))
                    SelectorItems(index)
//                        .background()
                        .rotation3DEffect(Angle(degrees: indexDiff * 13.5),axis: (x: 0.0, y: 1.0, z: 0.0), perspective: 1.2)
                    .scaleEffect(y: 1 - CGFloat(abs(indexDiff) * 0.03))
                }
            }
            
            .padding(.horizontal, 144.5)
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden )
        .scrollPosition(id: $exposureIndex , anchor :.center)
        .scrollTargetBehavior(.viewAligned)
        .frame(width:330, height: 50)
        .overlay(){
            indicator
        }
    }
    
    
    var indicator : some View
    {
        VStack() {
            Text("\(exposureConstants[exposureIndex ?? 0] > 0 ? "+\(exposureConstants[exposureIndex ?? 0])" : "\(exposureConstants[exposureIndex ?? 0])")")
                .monospaced()
                .fontWeight(.medium)
                .font(.subheadline)
            Spacer()
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 2, height: 25)
        }
        .frame(height: 50)
        .allowsHitTesting(false)
    }
    
    func SelectorItems(_ index: Int) -> some View {
        let len = index % 3 == 0 ? 1 : 1.0
        let col: Color = index % 3 == 0 ? .white : .gray
        return VStack {
            Spacer()
            Rectangle()
                .fill(col)
                .frame(width: len, height: 14)
                
                .background(.black)
            
        }
        .id(index)
        .frame(width: 40, height: 50)
    }
    
    var ScrollForExposureCompat : some View {
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 0) {
                    ForEach(exposureConstants.indices, id: \.self) { index in
                        let indexDiff = Double(index - (exposureIndex ?? 0))
                        
                        SelectorItems(index)
                            .background(.black.opacity(0.001))
                            .onTapGesture {
                                withAnimation {
                                    value.scrollTo(index,anchor: .center)
                                    exposureIndex = index
                                }
                            }
                            .onAppear(){
                                value.scrollTo(exposureIndex,anchor: .center)
                            }
                            .rotation3DEffect(Angle(degrees: indexDiff * 13.5),axis: (x: 0.0, y: 1.0, z: 0.0), perspective: 1.2)
                            .scaleEffect(y: 1 - CGFloat(abs(indexDiff) * 0.03))
                    }
                }
                .padding(.horizontal, 12 * 13)
            }
            .scrollDisabled(true)
            .frame(width:330, height: 50)
            .overlay(){
                indicator
            }
        }
    }
}

#Preview {
    CameraView()
}
