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
    
    
    let logo: NSImageView = {
        let img = NSImageView()
        img.image = #imageLiteral(resourceName: "LogoBanner")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let copyrightLabel: NSTextField = {
        let label = NSTextField()
        label.font = NSFont(name: "Helvetica Neue Thin", size: 15)
        label.isBezeled = false
        label.isBordered = false
        label.isEditable = false
        label.alignment = .center
        label.backgroundColor = .clear
        label.stringValue = "\u{00A9} 2017 Charles Kenney"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let viewSourceButton: NSButton = {
        let button = NSButton(title: "view source", target: nil, action: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let launchOnStartupButton: NSButton = {
        let button = NSButton(checkboxWithTitle: "launch on startup", target: nil, action: nil)
        button.state = .on
        button.alignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupLogo()
        setupCopyrightLabel()
        setupViewSourceButton()
        setupLaunchOnStartupButton()
    }
    
    
    func setupView() {
    }
    
    
    func addViews() {
        self.view.addSubview(logo)
        self.view.addSubview(copyrightLabel)
        self.view.addSubview(viewSourceButton)
        self.view.addSubview(launchOnStartupButton)
    }
    
    
    func setupLogo() {
        logo.heightAnchor.constraint(equalToConstant: 120).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    func setupCopyrightLabel() {
        copyrightLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        copyrightLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        copyrightLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        copyrightLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10).isActive = true
    }
    
    
    func setupViewSourceButton() {
        viewSourceButton.target = self
        viewSourceButton.action = #selector(viewSource(_:))
        viewSourceButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewSourceButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewSourceButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewSourceButton.topAnchor.constraint(equalTo: copyrightLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    
    func setupLaunchOnStartupButton() {
        launchOnStartupButton.target = self
        launchOnStartupButton.action = #selector(changeLaunchOnStartup(_:))
        launchOnStartupButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        launchOnStartupButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        launchOnStartupButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        launchOnStartupButton.topAnchor.constraint(equalTo: viewSourceButton.bottomAnchor, constant: 20).isActive = true
    }

    
}



// MARK: - Actions
extension SettingsController {
    
    
    @objc func viewSource(_ sender: Any?) {
        
        let url = URL(string: "https://github.com/charliekenney23/cdn-fetch")!
        NSWorkspace.shared.open(url)
    }
    
    
    @objc func changeLaunchOnStartup(_ sender: NSButton) {
    
        print("changed launch on startup to \(sender.state)")
    }
    
    
}
