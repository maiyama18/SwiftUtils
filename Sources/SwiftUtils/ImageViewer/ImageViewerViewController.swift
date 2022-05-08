import UIKit

final class ImageViewerViewController: UIViewController {
    private let image: UIImage

    override public var prefersStatusBarHidden: Bool {
        true
    }

    init(image: UIImage) {
        self.image = image

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hostSwiftUIView(
            ImageViewerScreen(
                image: image,
                onCloseButtonTapped: { [weak self] in self?.dismiss(animated: true) },
                onShareButtonTapped: { [weak self] in
                    guard let self = self else { return }
                    CommonRouting.showShare(from: self, item: self.image)
                }
            )
        )
    }
}
