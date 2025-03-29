//
//  SwiftUIView.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 03/01/25.
//

import SwiftUI

struct ZoomableImage: View { 
    let Images = ["IMG_0001","IMG_0002","IMG_0003","IMG_0004","IMG_0005","IMG_0006"]
    @State private var currentScale: CGFloat = 1.0
    @State private var finalScale: CGFloat = 1.0
    @State private var isZoomedIn: Bool = false
    @State private var SelectedIndex: Int = 0
    @State var aspectratio: CGFloat = 0.0
    var body: some View {
        if #available(iOS 17.0, *) {
            TabView(selection: $SelectedIndex) {
                ForEach(Images, id: \.self) { index in
                    testScrollView(index)
                        .ignoresSafeArea()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
    
    @available(iOS 17.0, *)
    func testScrollView(_ ImageView: String) -> some View {
            ScrollView([.horizontal, .vertical]){
                    Image(ImageView)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width * finalScale,
                               maxHeight: UIScreen.main.bounds.width * finalScale / aspectratio)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    currentScale = value
                                }
                                .onEnded { value in
                                    finalScale *= value
                                    currentScale = 1.0
                                }
                        )
                        .gesture(
                            TapGesture(count: 2) // Double-tap gesture
                                .onEnded {
                                    withAnimation(.spring()) {
                                        isZoomedIn.toggle()
                                        finalScale = isZoomedIn ? 5.0 : 1.0 // Toggle zoom level
                                    }
                                }
                        )
                        .background(.black)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * finalScale,
                    maxHeight: UIScreen.main.bounds.width * finalScale / aspectratio)
            .defaultScrollAnchor(.center)
            .scrollBounceBehavior(.automatic)
            .scrollDisabled(!isZoomedIn)
            .ignoresSafeArea()
            .onAppear(){
                let width = UIImage(named: ImageView)?.size.width
                let height = UIImage(named: ImageView)?.size.height
                aspectratio = width! / height!
            }
    }
}

#Preview {
    ZoomableImage()
}
