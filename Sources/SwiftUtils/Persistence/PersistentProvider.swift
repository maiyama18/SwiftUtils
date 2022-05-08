import CoreData

public final class PersistentProvider {
    public struct Transformer {
        public let name: String
        public let valueTransformer: ValueTransformer
        
        public init(name: String, valueTransformer: ValueTransformer) {
            self.name = name
            self.valueTransformer = valueTransformer
        }
    }
    
    public let persistentContainer: NSPersistentCloudKitContainer

    public init(modelURL: URL, modelFileName: String, containerIdentifier: String, transformers: [Transformer]) {
        for transformer in transformers {
            ValueTransformer.setValueTransformer(transformer.valueTransformer, forName: .init(rawValue: transformer.name))
        }

        let model = NSManagedObjectModel(contentsOf: modelURL)!
        persistentContainer = NSPersistentCloudKitContainer(name: modelFileName, managedObjectModel: model)

        let storeDirectory = NSPersistentCloudKitContainer.defaultDirectoryURL()
        let storeURL = storeDirectory.appendingPathComponent("Synced.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: containerIdentifier)
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        persistentContainer.persistentStoreDescriptions = [description]

        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("failed to load CoreData store: \(error)")
            }
        }
    }
}
