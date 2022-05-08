import SwiftUI

struct ImageViewerScreen: View {
    private let image: UIImage
    private let onCloseButtonTapped: () -> Void
    private let onShareButtonTapped: () -> Void

    init(image: UIImage, onCloseButtonTapped: @escaping () -> Void, onShareButtonTapped: @escaping () -> Void) {
        self.image = image
        self.onCloseButtonTapped = onCloseButtonTapped
        self.onShareButtonTapped = onShareButtonTapped
    }

    var body: some View {
        ZStack(alignment: .top) {
            ImageView(image: image)

            HStack {
                Button(action: onShareButtonTapped) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding(12)
                }
                .offset(x: 12, y: 12)

                Spacer()

                Button(action: onCloseButtonTapped) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding(12)
                }
                .offset(x: -12, y: 12)
            }
        }
        .background(Color.black)
    }
}
