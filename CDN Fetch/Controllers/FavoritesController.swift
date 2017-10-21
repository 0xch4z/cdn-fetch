//
//  FavoritesController.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/18/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import CKNavigation
import Cocoa

class FavoritesController: CKNavigatableViewController {
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func setupView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        self.view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        self.view.wantsLayer = true
    }
    
    
    @objc func goBack(_ sender: Any?) {
        self.navigationController?.popViewController()
    }
    
}
