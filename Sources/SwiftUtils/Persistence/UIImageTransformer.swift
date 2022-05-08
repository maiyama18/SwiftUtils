import CoreData
import UIKit

public final class UIImageTransformer: ValueTransformer {
    public override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
        } catch {
            print(error)
            return nil
        }
    }

    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
