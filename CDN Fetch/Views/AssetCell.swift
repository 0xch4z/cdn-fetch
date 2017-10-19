//
//  AssetCell.swift
//  CDNFetchBeta
//
//  Created by Charles Kenney on 10/18/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa


class AssetCell: NSTableCellView {
    
    
    var assetName: String? {
        didSet {
            if let text = assetName {
                let ext = text.getFileExtension()
                nameLabel.stringValue = text
                fileImage = NSWorkspace.shared.icon(forFileType: ext)
                assetType = AssetType.getFileType(forExtension: ext)
            }
        }
    }
    
    
    var assetType: AssetType = .generic {
        didSet {
            setupFetchMenu()
        }
    }
    
    var fileImage = NSWorkspace.shared.icon(forFileType: "") {
        didSet {
            setupFileImage()
        }
    }

    
    var fetchMenu = NSMenu()
    
    
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
    
    
    let fileImageView: NSImageView = {
        let img = NSImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    let fetchButton: NSButton = {
        let btn = NSButton(image: #imageLiteral(resourceName: "Fetch"), target: nil, action: nil)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupView()
        addViews()
        setupFileImageView()
        setupFileImage()
        setupFetchButton()
        setupFetchMenu()
        setupNameLabel()
    }
    
    
    func setupView() {
        self.wantsLayer = false
        fetchMenu.delegate = self
    }
    
    
    func addViews() {
        self.addSubview(fileImageView)
        self.addSubview(nameLabel)
        self.addSubview(fetchButton)
    }
    
    
    func setupFileImageView() {
        fileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        fileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        fileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    }
    
    
    func setupFileImage() {
        fileImageView.image = fileImage
    }
    
    func setupFetchButton() {
        fetchButton.target = self
        fetchButton.action = #selector(showMenu(_:))
        fetchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fetchButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        fetchButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        fetchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
    
    func setupFetchMenu() {
        fetchMenu = NSMenu()
        switch (assetType) {
        case .javascript:
            // create javascript item
            let javascriptItem = NSMenuItem(title: "get <script>", action: #selector(fetchScriptTag(_:)), keyEquivalent: "")
            javascriptItem.target = self
            fetchMenu.addItem(javascriptItem)
            break
        case .css:
            // create css item
            let cssItem = NSMenuItem(title: "get <link>", action: #selector(fetchLinkTag(_:)), keyEquivalent: "")
            cssItem.target = self
            fetchMenu.addItem(cssItem)
            break
        default:
            break
        }
        // create uri item
        let uriItem = NSMenuItem(title: "get URI", action: #selector(copyUri(_:)), keyEquivalent: "")
        uriItem.target = self
        fetchMenu.addItem(uriItem)
        // create favorite item
        let favoriteItem = NSMenuItem(title: "add favorite", action: #selector(addToFavorites(_:)), keyEquivalent: "")
        favoriteItem.target = self
        fetchMenu.addItem(favoriteItem)
    }
    
    func setupNameLabel() {
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: fileImageView.rightAnchor, constant: 5).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}



// MARK: - Actions
extension AssetCell: NSMenuDelegate {
    
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }
    
    @objc func showMenu(_ sender: NSButtonCell) {
        fetchMenu.popUp(positioning: fetchMenu.items[0], at: self.fetchButton.frame.origin, in: self)
        fetchMenu.item(at: 1)?.isEnabled = true
        fetchMenu.setAccessibilitySelected(true)
    }
    
    
    @objc func fetchLinkTag(_ sender: Any?) {
        print("fetch link tag pressed")
    }
    
    
    @objc func fetchScriptTag(_ sender: Any?) {
        print("fetch script tag pressed")
    }
    
    
    @objc func copyUri(_ sender: Any?) {
        print("copy uril tag pressed")
    }
    
    
    @objc func addToFavorites(_ sender: Any?) {
        print("add to favorites pressed")
    }
    
    
}
