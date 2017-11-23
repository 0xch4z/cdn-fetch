//
//  ResultCell.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/18/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

class ResultCell: NSTableCellView {

    var nameText: String? {
        didSet {
            if let text = nameText {
                self.nameLabel.stringValue = text
            }
        }
    }

    var descriptionText: String? {
        didSet {
            if let text = descriptionText {
                self.descriptionLabel.stringValue = text
            }
        }
    }

    var licenseText: String? {
        didSet {
            if let text = licenseText {
                self.licenseLabel.stringValue = text
            }
        }
    }

    let nameLabel: NSTextField = {
        let label = NSTextField(string: "")
        label.font = NSFont(name: "Helvetica Neue Thin", size: 20)
        label.backgroundColor = .clear
        label.textColor = .white
        label.isBordered = false
        label.isEditable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let licenseLabel: NSTextField = {
        let label = NSTextField(string: "")
        label.font = NSFont(name: "Helvetica Neue", size: 14)
        label.backgroundColor = .clear
        label.alignment = .center
        label.textColor = .white
        label.isBezeled = false
        label.isBordered = false
        label.isEditable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: NSTextField = {
        let label = NSTextField(string: "")
        label.font = NSFont(name: "Helvetica Neue", size: 12)
        label.backgroundColor = .clear
        label.textColor = .white
        label.usesSingleLineMode = false
        label.cell!.isScrollable = false
        label.cell!.wraps = true
        label.lineBreakMode = .byWordWrapping
        label.isBezeled = false
        label.isBordered = false
        label.isEditable = false
        label.allowsDefaultTighteningForTruncation = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        addViews()
        setupView()
        setupNameLabel()
        setupLicenseLabel()
        setupDescriptionLabel()
    }

    func setupView() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1).cgColor
    }

    func addViews() {
        self.addSubview(nameLabel)
        self.addSubview(licenseLabel)
        self.addSubview(descriptionLabel)
    }

    func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -110).isActive = true
    }

    func setupLicenseLabel() {
        licenseLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        licenseLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        licenseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        licenseLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }

    func setupDescriptionLabel() {
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -43).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }

}
