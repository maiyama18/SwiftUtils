import CoreLocation

public protocol LocationServiceProtocol {
    func requestPermission()
    func getLocation() -> CLLocationCoordinate2D?
    func checkPermission() -> LocationPermission
}

public final class LocationService: LocationServiceProtocol {
    var locationManager = CLLocationManager()

    public static let shared = LocationService()

    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    public func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    public func getLocation() -> CLLocationCoordinate2D? {
        locationManager.location?.coordinate
    }

    public func checkPermission() -> LocationPermission {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return .allowed
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .notDetermined
        }
    }
}
