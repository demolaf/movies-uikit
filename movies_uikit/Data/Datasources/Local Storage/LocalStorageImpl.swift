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
        completion: @escaping (Result<ObjectType, Error>) -> Void
    ) {
        let result = realm?.object(
            ofType: (ObjectType.self as! Object.Type).self,
            forPrimaryKey: (ObjectType.self as! Object.Type).primaryKey()
        )
        completion(.success(result as! ObjectType))
    }

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?,
        completion: @escaping (Result<[ObjectType], Error>) -> Void
    ) {
        var results = realm?.objects((ObjectType.self as! Object.Type).self)
        if let predicate = predicate {
            results = results?.filter(predicate)
        }
        var convertToObjects = [ObjectType]()
        results?.sorted(byKeyPath: sortBy).forEach({ object in
            convertToObjects.append(object as! ObjectType)
        })
        completion(.success(convertToObjects))
    }

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?
    ) -> Observable<[ObjectType]> {
        var results = realm?.objects((ObjectType.self as! Object.Type).self)

        if let predicate = predicate {
            results = results?.filter(predicate)
        }

        return Observable<[ObjectType]>.create {observer in
            let notificationToken = results?.observe { changes in
                switch changes {
                case .initial(let values):
                    let sortedValues = Array(values.sorted(byKeyPath: sortBy).map { $0 as! ObjectType })
                    observer.onNext(sortedValues)
                case .update(_, let deletions, let insertions, let modifications):
                    // Handle deletions, insertions, and modifications
                    // Update relay value accordingly
                    debugPrint("Deletions: \(deletions), Insertions: \(insertions), Modifications: \(modifications)")
                    if let sortedResults = results?.sorted(byKeyPath: sortBy).map({ $0 as! ObjectType }) {
                        observer.onNext(Array(sortedResults))
                    }
                case .error(let error):
                    debugPrint("Error occurred: \(error)")
                }
            }
            return Disposables.create {
                notificationToken?.invalidate()
            }
        }
    }
    // swiftlint:enable force_cast
}
