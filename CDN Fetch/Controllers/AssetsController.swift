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
            assetsTable.reloadData()
        }
    }
    
    
    var version: String? {
        didSet {
            assetsTable.reloadData()
        }
    }
    
    
    var versions: [String]? {
        didSet {
            // TODO: add to versions menu
            print("got versions")
        }
    }
    
    
    var assets: Dictionary<String, Any?>? {
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
        fetchAssets(for: library)
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
    
    
//    // MARK: - Query for library
//    func searchLibraries(for term: String) {
//        // make request
//        Alamofire.request("https://api.cdnjs.com/libraries?search=\(term)&fields=license,description").responseJSON { res in
//
//            guard let data = res.result.value as? [String:Any] else {
//                return print("no data")
//            }
//
//            guard let results = data["results"] as? [[String:Any]] else {
//                return print("no results")
//            }
//
//            // set results
//            self.searchResults = results
//        }
//    }
    
    func fetchAssets(for library: String) {
        // make request
        Alamofire.request("https://api.cdnjs.com/libraries/\(library)").responseJSON { res in
            
            guard let data = res.result.value as? [String:Any?] else {
                return print("no data")
            }
            
            guard let assetsData = data["assets"] as? Array<Dictionary<String, Any?>> else {
                return print("no assets")
            }
            
            var versions: [String] = []
            var assets: [String:Any?] = [:]
            
            for asset in assetsData {
                // format version to corresponding assets for controller
                guard let version = asset["version"] as? String,
                      let files = asset["files"] as? [String] else {
                    print("no version/files")
                    continue
                }
                versions.append(version)
                assets[version] = files
            }
            
            // get latest version
            if let latestVersion = data["version"] as? String {
                self.version = latestVersion
            } else {
                self.version = versions.first ?? ""
            }
            
            self.assets = assets
            self.versions = versions
        }
    }
    
    
}



// MARK: - Table View Delegate
extension AssetsController: NSTableViewDelegate, NSTableViewDataSource {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        let currVersion = version ?? ""
        let currAssets = assets?[currVersion] as? [String] ?? []
        return currAssets.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // get data
        let currVersion = version ?? ""
        let currAssets = assets?[currVersion] as? [String] ?? []
        let currAsset = currAssets[row]
        // create row
        let id = NSUserInterfaceItemIdentifier(rawValue: "COL")
        let cell = AssetCell()
        cell.identifier = id
        cell.assetName = currAsset
        cell.library = library ?? ""
        cell.version = version ?? ""
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
