//
//  LocalStorageRepository.swift
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol LocalStorage {
    func create(object: AnyObject)

    func update(object: AnyObject)

    func updateProperty(callback: @escaping () -> Void)

    func read<ObjectType: AnyObject>(
        object: ObjectType.Type,
        completion: @escaping (Result<ObjectType, Error>) -> Void
    )

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?,
        completion: @escaping (Result<[ObjectType], Error>) -> Void
    )

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?
    ) -> Observable<[ObjectType]>
}
