//
//  LocalStorageRepositoryImpl.swift
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class LocalStorageImpl: LocalStorage {
    let realm: Realm?

    var notificationToken: NotificationToken?

    init() {
        self.realm = try? Realm()
        debugPrint(Realm.Configuration.defaultConfiguration.fileURL ?? "No realm path")
    }

    func create(object: AnyObject) {
        do {
            if let object = object as? Object {
                try realm?.write {
                    realm?.add(object, update: .all)
                }
            }
        } catch {
            debugPrint(error)
        }
    }

    func update(object: AnyObject) {
        do {
            if let object = object as? Object {
                try realm?.write {
                    realm?.add(object, update: .modified)
                }
            }
        } catch {
            debugPrint(error)
        }
    }

    func updateProperty(callback: @escaping () -> Void) {
        do {
            realm?.beginWrite()
            callback()
            try realm?.commitWrite()
        } catch {
            debugPrint(error)
        }
    }

    // swiftlint:disable force_cast
    func read<ObjectType: AnyObject>(
        object: ObjectType.Type,
        completion: @escaping (AnyObject?, Error?) -> Void
    ) {
        do {
            realm?.object(
                ofType: (ObjectType.self as! Object.Type).self,
                forPrimaryKey: (ObjectType.self as! Object.Type).primaryKey()
            )
        } catch {
            debugPrint(error)
            completion(nil, error)
        }
    }

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?,
        completion: @escaping ([ObjectType], Error?) -> Void
    ) {
        do {
            var results = realm?.objects((ObjectType.self as! Object.Type).self)
            if let predicate = predicate {
                results = results?.filter(predicate)
            }
            var convertToObjects = [ObjectType]()
            results?.sorted(byKeyPath: sortBy).forEach({ object in
                convertToObjects.append(object as! ObjectType)
            })
            completion(convertToObjects, nil)
        } catch {
            debugPrint(error)
            completion([], error)
        }
    }

    func readAllWithChanges<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?
    ) -> BehaviorRelay<[ObjectType]> {
        let relay = BehaviorRelay<[ObjectType]>(value: [])
        var results = realm?.objects((ObjectType.self as! Object.Type).self)
        if let predicate = predicate {
            results = results?.filter(predicate)
        }
        notificationToken = results?.observe { changes in
            switch changes {
            case .initial(let values):
                let sortedValues = values.sorted(byKeyPath: sortBy)
                debugPrint("Initial values: \(sortedValues)")
                relay.accept(Array(sortedValues) as! [ObjectType])
            case .update(_, let deletions, let insertions, let modifications):
                // Handle deletions, insertions, and modifications
                // Update relay value accordingly
                debugPrint("Deletions: \(deletions), Insertions: \(insertions), Modifications: \(modifications)")
                if let sortedResults = results?.sorted(byKeyPath: sortBy) {
                    relay.accept(Array(sortedResults) as! [ObjectType])
                }
            case .error(let error):
                debugPrint("Error occurred: \(error)")
            }
        }
        // Retain the notification token somewhere for cleanup when needed
        // For example: self.notificationToken = notificationToken
        return relay
    }
    // swiftlint:enable force_cast
}
