import CoreData
import UIKit

final class UIImageTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
        } catch {
            print(error)
            return nil
        }
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
