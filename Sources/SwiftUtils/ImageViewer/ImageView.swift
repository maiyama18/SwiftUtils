import SwiftUI

struct ImageView: UIViewRepresentable {
    var image: UIImage

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 8
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never

        let imageView = context.coordinator.imageView
        imageView.frame = scrollView.bounds
        scrollView.addSubview(imageView)
        return scrollView
    }

    func makeCoordinator() -> Coordinator {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return Coordinator(imageView: imageView)
    }

    func updateUIView(_: UIScrollView, context _: Context) {}

    class Coordinator: NSObject, UIScrollViewDelegate {
        var imageView: UIImageView

        init(imageView: UIImageView) {
            self.imageView = imageView
        }

        func viewForZooming(in _: UIScrollView) -> UIView? {
            imageView
        }

        func scrollViewDidZoom(_: UIScrollView) {
            centerImage()
        }

        func centerImage() {
            let boundsSize = imageView.bounds.size
            var frameToCenter = imageView.frame

            if frameToCenter.size.width < boundsSize.width {
                frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
            } else {
                frameToCenter.origin.x = 0
            }

            if frameToCenter.size.height < boundsSize.height {
                frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
            } else {
                frameToCenter.origin.y = 0
            }

            imageView.frame = frameToCenter
        }
    }
}
