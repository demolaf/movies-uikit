//
//  LocalStorageRepository.swift
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation

protocol LocalStorage {
    func create(object: AnyObject)

    func update(object: AnyObject)

    func read<ObjectType: AnyObject>(
        object: ObjectType.Type,
        completion: @escaping (AnyObject?, Error?) -> Void
    )

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        completion: @escaping ([ObjectType], Error?) -> Void
    )
}
