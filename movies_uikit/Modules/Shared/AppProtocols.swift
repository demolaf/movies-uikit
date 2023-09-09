//
//  AppProtocols.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController

protocol AnyRouter {
    func push(to route: UIViewController, from vc: UIViewController)

    func pop(from vc: UIViewController)
}
