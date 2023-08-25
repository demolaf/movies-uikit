//
//  LaunchViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 25/08/2023.
//

import Foundation
import UIKit

protocol LaunchViewDelegate: AnyView {}

class LaunchViewController: UIViewController, LaunchViewDelegate {
    
    var presenter: AnyPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        (presenter as? LaunchPresenter)?.initialize()
    }
}
