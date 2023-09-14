//
//  LocalStorageRepositoryImpl.swift
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import RealmSwift
import RxSwift

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
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?,
        completion: @escaping ([ObjectType], Error?) -> Void
    ) {
        do {
            try realm?.write {
                var results = realm?.objects((ObjectType.self as! Object.Type).self)

                if let predicate = predicate {
                    results = results?.filter(predicate)
                }

                var convertToObjects = [ObjectType]()

                results?.sorted(byKeyPath: sortBy).forEach({ object in
                    convertToObjects.append(object as! ObjectType)
                })
                completion(convertToObjects, nil)
            }
        } catch {
            debugPrint(error)
            completion([], error)
        }
    }

    func readAllWithChanges<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        completion: @escaping ([ObjectType], Error?) -> Void
    ) {
        do {
            try realm?.write {
                let results = realm?.objects((ObjectType.self as! Object.Type).self)
//                results?.observe(on: .main, { change in
//                    switch change {
//                    case .initial(let value):
//                        <#code#>
//                    case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
//                        <#code#>
//                    case .error(_):
//                        <#code#>
//                    }
//                })
//                completion(convertToObjects, nil)
            }
        } catch {
            debugPrint(error)
            completion([], error)
        }
    }
    // swiftlint:enable force_cast
}
