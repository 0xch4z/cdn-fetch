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
    
    
    let header: NavigationHeader = {
        let header = NavigationHeader()
        header.headingLabel.stringValue = "Favorites"
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    
    override func loadView() {
        self.view = NSView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupHeader()
    }
    
    
    func setupView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        self.view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        self.view.wantsLayer = true
    }
    
    
    func addViews() {
        self.view.addSubview(header)
    }
    
    
    func setupHeader() {
        header.backButton.target = self
        header.backButton.action = #selector(goBack(_:))
        header.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        header.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
}



// MARK: - Actions
extension FavoritesController {
    
    
    @objc func goBack(_ sender: Any?) {
        self.navigationController?.popViewController()
    }
    
}
