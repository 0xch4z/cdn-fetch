//
//  AssetsController.swift
//  CDNFetchBeta
//
//  Created by Charles Kenney on 10/18/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa
import CKNavigation
import Alamofire


class AssetsController: CKNavigatableViewController {
    
    
    var library: String? {
        didSet {
            
        }
    }
    
    
    var assets: Array<Dictionary<String, Any>>? {
        didSet {
            assetsTable.reloadData()
        }
    }
    
    
    let header: AssetsHeader = {
        let header = AssetsHeader()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    
    let scrollView: NSScrollView = {
        let scroll = NSScrollView()
        scroll.wantsLayer = false
        scroll.backgroundColor = .clear
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    let assetsTable: NSTableView = {
        let table = NSTableView()
        table.rowHeight = 40
        table.wantsLayer = false
        table.headerView = nil
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    let column: NSTableColumn = {
        let col = NSTableColumn()
        col.identifier = NSUserInterfaceItemIdentifier(rawValue: "COL")
        return col
    }()
    
    
    convenience init(library: String) {
        self.init(nibName: nil, bundle: nil)
        self.library = library
    }
    
    
    override func loadView() {
        self.view = NSView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupHeader()
        setupAssetsTable()
    }
    
    
    func setupView() {
        self.view.wantsLayer = true
    }
    
    
    func addViews() {
        self.view.addSubview(scrollView)
        self.view.addSubview(header)
    }
    
    
    func setupHeader() {
        header.backButton.target = self
        header.backButton.action = #selector(goBack(_:))
        header.nameLabel.stringValue = library ?? ""
        header.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        header.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setupAssetsTable() {
        assetsTable.addTableColumn(column)
        assetsTable.delegate = self
        assetsTable.dataSource = self
        scrollView.documentView = assetsTable
        scrollView.contentView.drawsBackground = false
        scrollView.hasVerticalScroller = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 445).isActive = true
    }
    
    
}



// MARK: - Networking Stuff
extension AssetsController {
    
    
    
    
    
}



// MARK: - Table View Delegate
extension AssetsController: NSTableViewDelegate, NSTableViewDataSource {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let id = NSUserInterfaceItemIdentifier(rawValue: "COL")
        let cell = AssetCell()
        cell.identifier = id
        cell.assetName = "main.js"
        cell.library = "jquery"
        cell.version = "3.2.1"
        return cell
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    
}



extension AssetsController {
    
    
    @objc func goBack(_ sender: Any?) {
        self.navigationController!.popViewController()
    }
    
}
