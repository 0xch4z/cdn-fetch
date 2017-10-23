//
//  FavoriteCell.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/23/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

class FavoriteCell: NSTableCellView {
    
    
    var assetName: String? {
        didSet {
            if let text = assetName {
                let ext = AssetType.getExtensionFor(fileName: text)
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
    
    
    private var assetUri: String {
        let base = "https://cdnjs.cloudflare.com/ajax/libs"
        return "\(base)/\(library ?? "")/\(version ?? "")/\(assetName ?? "")"
    }
    
    
    var fetchMenu = NSMenu()
    
    
    let libraryLabel: NSTextField = {
        let label = NSTextField()
        label.isBezeled = false
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont(name: "Helvetica Neue", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let nameLabel: NSTextField = {
        let label = NSTextField()
        label.isBezeled = false
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont(name: "Apple SD Gothic Neo", size: 12)
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
    
    
    var library: String? {
        didSet {
            setupLibraryLabelText()
        }
    }
    
    
    var version: String? {
        didSet {
            setupLibraryLabelText()
        }
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupView()
        addViews()
        setupFileImageView()
        setupFileImage()
        setupFetchButton()
        setupFetchMenu()
        setupLibraryLabel()
        setupLibraryLabelText()
        setupNameLabel()
        setupPasteboard()
    }
    
    
    func setupView() {
        self.wantsLayer = false
        fetchMenu.delegate = self
    }
    
    
    func addViews() {
        self.addSubview(fileImageView)
        self.addSubview(libraryLabel)
        self.addSubview(nameLabel)
        self.addSubview(fetchButton)
    }
    
    
    func setupFileImageView() {
        fileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        fileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    }
    
    
    func setupFileImage() {
        fileImageView.image = fileImage
    }
    
    func setupFetchButton() {
        fetchButton.target = self
        fetchButton.action = #selector(showMenu(_:))
        fetchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fetchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        fetchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
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
        let removeFavorite = NSMenuItem(title: "remove favorite", action: #selector(removeFromFavorites(_:)), keyEquivalent: "")
        removeFavorite.target = self
        removeFavorite.tag = fetchButton.tag
        fetchMenu.addItem(removeFavorite)
    }
    
    
    func setupLibraryLabel() {
        libraryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.125).isActive = true
        libraryLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        libraryLabel.leftAnchor.constraint(equalTo: fileImageView.rightAnchor, constant: 5).isActive = true
        libraryLabel.rightAnchor.constraint(equalTo: fetchButton.leftAnchor, constant: 5).isActive = true
    }
    
    
    func setupLibraryLabelText() {
        libraryLabel.stringValue = "\(library ?? "") v\(version ?? "")"
    }
    
    
    func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: libraryLabel.bottomAnchor, constant: 2.5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: fileImageView.rightAnchor, constant: 5).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: fetchButton.leftAnchor, constant: -5).isActive = true
    }
    
    
    func setupPasteboard() {
        
    }
    
    
}



// MARK: - Actions
extension FavoriteCell: NSMenuDelegate {
    
    
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }
    
    @objc func showMenu(_ sender: NSButtonCell) {
        fetchMenu.popUp(positioning: fetchMenu.items[0], at: self.fetchButton.frame.origin, in: self)
        fetchMenu.item(at: 1)?.isEnabled = true
        fetchMenu.setAccessibilitySelected(true)
    }
    
    
    @objc func fetchLinkTag(_ sender: Any?) {
        let tag = "<link rel=\"stylesheet\" href=\"\(assetUri)\" />"
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: self)
        pasteboard.setString(tag, forType: .string)
    }
    
    
    @objc func fetchScriptTag(_ sender: Any?) {
        let tag = "<script src=\"\(assetUri)\"></script>"
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: self)
        pasteboard.setString(tag, forType: .string)
    }
    
    
    @objc func copyUri(_ sender: Any?) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: self)
        pasteboard.setString(assetUri, forType: .string)
        // test (ref for deleting favorites)
        if let button = sender as? NSMenuItem {
            print(button.tag)
        }
    }
    
    
    @objc func removeFromFavorites(_ sender: NSMenuItem) {
        let index = sender.tag
        print("index \(index) should be deleted!")
        // dispatch notification to delete self
    }
    
}
