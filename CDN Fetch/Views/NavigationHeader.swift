//
//  NavigationHeader.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/19/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

class NavigationHeader: NSView {
    
    let backButton: NSButton = {
        let btn = NSButton(image: #imageLiteral(resourceName: "BackButton"), target: nil, action: nil)
        btn.isBordered = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let headingLabel: NSTextField = {
        let label = NSTextField()
        label.alignment = .center
        label.isBezeled = false
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont(name: "Helvetica Neue Thin", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupView()
        addViews()
        setupBackButton()
        setupHeadingLabel()
    }
    
    
    func setupView() {
        self.wantsLayer = true
        self.layer!.backgroundColor = .clear
    }
    
    
    func addViews() {
        self.addSubview(backButton)
        self.addSubview(headingLabel)
    }
    
    
    // Add back button constraints
    func setupBackButton() {
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
    }
    
    
    // Add name label constraints
    func setupHeadingLabel() {
        headingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        headingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        headingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 55).isActive = true
        headingLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -55).isActive = true
    }
    
    
}


