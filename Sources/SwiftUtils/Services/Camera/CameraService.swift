import AVFoundation
import UIKit

public protocol CameraServiceProtocol {
    func checkPermission() -> CameraPermission
    func requestCameraPermission() async -> Bool
}

public class CameraService: CameraServiceProtocol {
    public static let shared = CameraService()

    init() {}

    public func checkPermission() -> CameraPermission {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return .unAvailable
        }

        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            return .allowed
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .notDetermined
        }
    }

    public func requestCameraPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .video) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
