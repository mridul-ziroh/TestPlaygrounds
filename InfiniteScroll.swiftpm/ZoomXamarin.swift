//
//  ContentView.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 13/02/25.
//


//
//  ZoomXamarin.swift
//  ZunuDrive
//
//  Created by mridul-ziroh on 13/02/25.
//

import UIKit
import SwiftUI
struct ZoomXamarin: View {
    var body: some View {
        ZoomableImageViewRepresentable2(imageName: "exampleImage")
            .edgesIgnoringSafeArea(.all) // Optional: Make it occupy the full screen
    }
}
#Preview {
    ZoomXamarin()
}
struct ZoomableImageViewRepresentable2: UIViewRepresentable {
    let imageName: String

    func makeUIView(context: Context) -> ZoomableImageView2 {
        
        let zoomableImageView = ZoomableImageView2()
        zoomableImageView.image = UIImage(named: "IMG_0001")
        return zoomableImageView
    }

    func updateUIView(_ uiView: ZoomableImageView2, context: Context) {
        // Update the view if needed (e.g., for dynamic content changes)
    }
}
class ZoomableImageView2: UIView, UIScrollViewDelegate {
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()

    // Scale factor to track zoom level
    public static var scaleFactor: CGFloat = 1.0

    var image: UIImage? {
        get { imageView.image }
        set {
            imageView.image = newValue
            configureImageView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeComponents()
    }

    private func initializeComponents() {
        // Configure scroll view
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = 1.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.frame = bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Configure image view
        imageView.contentMode = .scaleAspectFit
        imageView.frame = bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Add subviews
        scrollView.addSubview(imageView)
        addSubview(scrollView)

        // Add double-tap gesture recognizer
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGesture)
    }

    private func configureImageView() {
        guard let image = image else { return }
        // Calculate the aspect-fit frame for the image
        imageView.frame = calculateAspectFitFrame(for: image, in: imageView.bounds.size)
        scrollView.contentSize = imageView.frame.size
    }

    @objc private func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
        ZoomableImageView2.scaleFactor = scrollView.zoomScale
    }

    // UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // Center the image view when zooming
        let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0)
        imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                                   y: scrollView.contentSize.height * 0.5 + offsetY)

        ZoomableImageView2.scaleFactor = scrollView.zoomScale
    }

    private func calculateAspectFitFrame(for image: UIImage, in containerSize: CGSize) -> CGRect {
        let imageSize = image.size

        // Calculate the scale factor to fit the image in the container
        let widthScale = containerSize.width / imageSize.width
        let heightScale = containerSize.height / imageSize.height
        let scale = min(widthScale, heightScale)

        // Calculate the new size and position for the image
        let newWidth = imageSize.width * scale
        let newHeight = imageSize.height * scale
        let xOffset = (containerSize.width - newWidth) / 2.0
        let yOffset = (containerSize.height - newHeight) / 2.0

        return CGRect(x: xOffset, y: yOffset, width: newWidth, height: newHeight)
    }
}
