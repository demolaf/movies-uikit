//
//  LocalStorageRepositoryImpl.swift
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import RealmSwift

class LocalStorageImpl: LocalStorage {
    let realm: Realm?

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

    // swiftlint:disable force_cast
    func read<ObjectType: AnyObject>(
        object: ObjectType,
        completion: @escaping (AnyObject?, Error?) -> Void
    ) {
        do {
            try realm?.write {
                realm?.object(
                    ofType: (ObjectType.self as! Object.Type).self,
                    forPrimaryKey: (ObjectType.self as! Object.Type).primaryKey()
                )
            }
        } catch {
            debugPrint(error)
            completion(nil, error)
        }
    }

    func readAll<ObjectType: AnyObject>(
        object: ObjectType,
        completion: @escaping ([ObjectType], Error?) -> Void
    ) {
        do {
            try realm?.write {
                let results = realm?.objects((ObjectType.self as! Object.Type).self)

                var convertToObjects = [ObjectType]()

                results?.sorted(byKeyPath: "").forEach({ object in
                    convertToObjects.append(object as! ObjectType)
                })
                completion(convertToObjects, nil)
            }
        } catch {
            debugPrint(error)
            completion([], error)
        }
    }
    // swiftlint:enable force_cast
}
