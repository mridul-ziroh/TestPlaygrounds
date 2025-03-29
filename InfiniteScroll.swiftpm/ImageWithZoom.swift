//
//  ZoomTech.swift
//  ZunuDrive
//
//  Created by mridul-ziroh on 11/02/25.
//
import Foundation
import SwiftUI
import UIKit
struct ImageWithZoomView: View {
    var uiImage: UIImage
    @Binding var isTopBottomOverlayVisible: Bool
    @State private var imageSize: CGSize = .zero
    
    var body: some View {
        GeometryReader { proxy in
            Image(uiImage: uiImage)
                .resizable()
                .onAppear(){
                    DispatchQueue.main.async {
                        let imageAspectRatio = uiImage.size.width / uiImage.size.height
                        let frameWidth = proxy.size.width
                        let scaledHeight = frameWidth / imageAspectRatio
                        self.imageSize = CGSize(width: frameWidth, height: scaledHeight)
                    }
                }
                .scaledToFit()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipShape(Rectangle())
                .gesture(TapGesture(count: 1).onEnded({ Void in
                    isTopBottomOverlayVisible.toggle()
                }))
                .modifier(ImageModifier(contentSize: imageSize, isTopBottomOverlayVisible: $isTopBottomOverlayVisible))
                
        }.ignoresSafeArea()
    }
}

#Preview {
    ImageWithZoomView(uiImage: UIImage(named: "IMG_0001")!, isTopBottomOverlayVisible: .constant(true))
}
struct ImageModifier: ViewModifier {
    private var contentSize: CGSize
    private var min: CGFloat = 1.0
    private var max: CGFloat = 5.0
    @State var currentScale: CGFloat = 1.0
    
    @Binding var isTopBottomOverlayVisible: Bool

    init(contentSize: CGSize, isTopBottomOverlayVisible: Binding<Bool>) {
        self.contentSize = contentSize // Initialize Binding
        self._isTopBottomOverlayVisible = isTopBottomOverlayVisible
    }
    
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            isTopBottomOverlayVisible = false
            if currentScale <= min { currentScale = max } else
            if currentScale >= max { currentScale = min } else {
                currentScale = ((max - min) * 0.5 + min) < currentScale ? max : min
            }
        }
    }
    
    var singleTapGesture: some Gesture {
        TapGesture(count: 1).onEnded {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if isTopBottomOverlayVisible {
                    isTopBottomOverlayVisible = false
                } else {
                    isTopBottomOverlayVisible = true
                }
            }
        }
    }
    
    var combinedTapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation(.easeInOut) {
                    isTopBottomOverlayVisible.toggle()
                }
            }
            .exclusively(before:
                TapGesture(count: 2)
                    .onEnded {
                        withAnimation(.easeInOut) {
                            if currentScale <= min {
                                currentScale = max
                            } else if currentScale >= max {
                                currentScale = min
                            } else {
                                currentScale = ((max - min) * 0.5 + min) < currentScale ? max : min
                            }
                        }
                    }
            )
    }
    
    func body(content: Content) -> some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            content
                .frame(width: Swift.max(contentSize.width * currentScale, 0),
                       height: Swift.max((contentSize.height.isNaN ? 0.0 : contentSize.height) * currentScale, 0),
                               alignment: .center)
                .modifier(PinchToZoom(minScale: min, maxScale: max, scale: $currentScale, isTopBottomOverlayVisible: $isTopBottomOverlayVisible))
        }
        .gesture(
            doubleTapGesture.simultaneously(with: singleTapGesture)
        )
        .animation(.easeInOut, value: currentScale)
    }
}

class PinchZoomView: UIView {
    let minScale: CGFloat
    let maxScale: CGFloat
    var baseScale: CGFloat = 1.0
    var isPinching: Bool = false
    var scale: CGFloat = 1.0
    let scaleChange: (CGFloat) -> Void
    
    @Binding var isTopBottomOverlayVisible: Bool
    
    init(minScale: CGFloat,
           maxScale: CGFloat,
         currentScale: CGFloat,
         isTopBottomOverlayVisible: Binding<Bool>,
         scaleChange: @escaping (CGFloat) -> Void
    ) {
        self.minScale = minScale
        self.maxScale = maxScale
        self.baseScale = currentScale
        self.scale = currentScale
        self.scaleChange = scaleChange
        self._isTopBottomOverlayVisible = isTopBottomOverlayVisible
        super.init(frame: .zero)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(gesture:)))
        pinchGesture.cancelsTouchesInView = false
        addGestureRecognizer(pinchGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func pinch(gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began:
            baseScale = scale
            self.isTopBottomOverlayVisible = false

        case .changed, .ended:
            let newScale = baseScale * gesture.scale // Apply scaling relative to baseScale
            scale = min(max(newScale, minScale), maxScale)
            scaleChange(scale)

        case .cancelled, .failed:
            baseScale = 1.0
            scale = 1.0

        default:
            break
        }
    }
}

struct PinchZoom: UIViewRepresentable {
    let minScale: CGFloat
    let maxScale: CGFloat
    @Binding var scale: CGFloat
    @Binding var isPinching: Bool
    @Binding var isTopBottomOverlayVisible: Bool
    
    func makeUIView(context: Context) -> PinchZoomView {
        let pinchZoomView = PinchZoomView(minScale: minScale, maxScale: maxScale, currentScale: scale, isTopBottomOverlayVisible: $isTopBottomOverlayVisible, scaleChange: { scale = $0 })
        return pinchZoomView
    }
    
    func updateUIView(_ pageControl: PinchZoomView, context: Context) { }
}

struct PinchToZoom: ViewModifier {
    let minScale: CGFloat
    let maxScale: CGFloat
    @Binding var scale: CGFloat
    @State var anchor: UnitPoint = .center
    @State var isPinching: Bool = false
    
    @Binding var isTopBottomOverlayVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale, anchor: anchor)
            .animation(.spring(), value: isPinching)
            .overlay(PinchZoom(minScale: minScale, maxScale: maxScale, scale: $scale, isPinching: $isPinching, isTopBottomOverlayVisible: $isTopBottomOverlayVisible))
    }
}
