import UIKit

public enum CommonRouting {
    public static func showDestructiveActionConfirmation(from originVC: UIViewController, message: String, confirmationText: String, onConfirmed: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: confirmationText, style: .destructive, handler: { _ in onConfirmed() }))
        alertController.addAction(.init(title: "キャンセル", style: .cancel))
        originVC.present(alertController, animated: true)
    }

    public static func showSimpleError(from originVC: UIViewController, message: String) {
        let alertController = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        originVC.present(alertController, animated: true)
    }
    
    public static func showCamera<C: UIViewController>(from originVC: C, allowsEditing: Bool)
        where C: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    {
        let picker = UIImagePickerController()
        picker.delegate = originVC
        picker.sourceType = .camera
        picker.allowsEditing = allowsEditing
        originVC.present(picker, animated: true)
    }
    
    public static func showShare(from originVC: UIViewController, item: Any) {
        let shareVC = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        originVC.present(shareVC, animated: true)
    }
}
