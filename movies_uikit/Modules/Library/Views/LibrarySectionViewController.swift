//
//  LibrarySectionViewController.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 03/09/2023.
//

import UIKit

/// Custom dynamically instantiated view controller for library sections
class LibrarySectionViewController: UIViewController {

    var pageViewController: LibraryViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
}
