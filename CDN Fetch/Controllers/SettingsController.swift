//
//  SettingsController.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/18/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa
import CKNavigation

class SettingsController: CKNavigatableViewController {
    
    let button: NSButton = {
        let btn = NSButton()
        btn.title = "Back"
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func loadView() {
        self.view = NSView()
        print("i loaded")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupButton()
        print("finished view did load")
    }
    
    func setupView() {
        self.view.wantsLayer = true
        self.view.layer!.backgroundColor = NSColor.red.cgColor
    }
    
    func addViews() {
        self.view.addSubview(button)
    }
    
    func setupButton() {
        button.target = self
        button.action = #selector(popViewController(_:))
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 125).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func popViewController(_ sender: Any?) {
        self.navigationController!.popViewController()
    }
    
}
