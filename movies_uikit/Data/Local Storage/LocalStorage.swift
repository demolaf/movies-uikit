//
//  LocalStorageRepository.swift
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import RealmSwift

protocol LocalStorage {
    func create<ObjectType: Object>(
        object: ObjectType,
        realmUpdatePolicy: Realm.UpdatePolicy
    )

    func read<ObjectType: Object>(
        object: ObjectType.Type,
        completion: @escaping (ObjectType?, Error?) -> Void
    )

    func readAll<ObjectType: Object>(
        object: ObjectType.Type,
        completion: @escaping (Results<ObjectType>?, Error?) -> Void
    )
}
