//
//  AssetsHeader.swift
//  CDNFetchBeta
//
//  Created by Charles Kenney on 10/19/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

class AssetsHeader: NSView {
    
    let backButton: NSButton = {
        let btn = NSButton(image: #imageLiteral(resourceName: "BackButton"), target: nil, action: nil)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let testImage: NSImageView = {
        let img = NSImageView()
        img.image = NSWorkspace.shared.icon(forFileType: "rb")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let nameLabel: NSTextField = {
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
        setupNameLabel()
    }
    
    
    func setupView() {
        self.wantsLayer = true
        self.layer!.backgroundColor = .clear
    }
    
    
    func addViews() {
        self.addSubview(backButton)
        self.addSubview(nameLabel)
    }
    
    
    func setupBackButton() {
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
    }
    
    
    func setupNameLabel() {
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 55).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -55).isActive = true
    }
    
    
    func setupTestImage() {
        testImage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        testImage.widthAnchor.constraint(equalToConstant: 45).isActive = true
        testImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        testImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
    }
    
    
}
