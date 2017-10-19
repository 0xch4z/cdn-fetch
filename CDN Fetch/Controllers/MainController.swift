//
//  MainController.swift
//  CDNFetchBeta
//
//  Created by Charles Kenney on 10/18/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa
import CKNavigation
import Alamofire


class MainController: CKNavigatableViewController {
    
    
    var searchResults: Array<Dictionary<String, Any>> = [[:]] {
        didSet {
            self.resultsTable.reloadData()
        }
    }
    
    
    var transitioningController: Bool = false
    
    
    // MARK: - Make library search field
    let searchField: NSSearchField = {
        let field = NSSearchField()
        field.font = NSFont(name: "Helvetica Neue Thin", size: 15)
        field.placeholderString = "Search a library"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    // MARK: - Make table container
    let scrollView: NSScrollView = {
        let scroll = NSScrollView()
        scroll.wantsLayer = false
        scroll.backgroundColor = .clear
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    // MARK: - Make results table view
    let resultsTable: NSTableView = {
        let table = NSTableView()
        table.rowHeight = 90
        table.wantsLayer = false
        table.headerView = nil
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    // MARK: - Make primary table column
    let column: NSTableColumn = {
        let col = NSTableColumn()
        col.identifier = NSUserInterfaceItemIdentifier(rawValue: "COL")
        return col
    }()
    
    
    override func loadView() {
        self.view = NSView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupSearchField()
        setupResultsTable()
        searchLibraries(for: "")
    }
    
    func setupView() {
        self.view.wantsLayer = true
    }
    
    
    func addViews() {
        self.view.addSubview(searchField)
        self.view.addSubview(scrollView)
    }
    
    
    // MARK: - Setup search field & constraints
    func setupSearchField() {
        searchField.target = self
        searchField.action = #selector(searchTermHasUpdated(_:))
        searchField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: 23).isActive = true
        searchField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        searchField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    // MARK: - Setup results table & constraints
    func setupResultsTable() {
        resultsTable.addTableColumn(column)
        resultsTable.delegate = self
        resultsTable.dataSource = self
        scrollView.documentView = resultsTable
        scrollView.contentView.drawsBackground = false
        scrollView.hasVerticalScroller = true
        scrollView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 15).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 445).isActive = true
        resultsTable.reloadData()
    }
    
    
}



// MARK: - Networking stuff
extension MainController: NSSearchFieldDelegate {
    
    
    @objc func searchTermHasUpdated(_ sender: NSTextField) {
        let term = sender.stringValue
        searchLibraries(for: term)
    }
    
    
    // MARK: - Query for library
    func searchLibraries(for term: String) {
        // make request
        Alamofire.request("https://api.cdnjs.com/libraries?search=\(term)&fields=license,description").responseJSON { res in
            
            guard let data = res.result.value as? [String:Any] else {
                return print("no data")
            }
            
            guard let results = data["results"] as? [[String:Any]] else {
                return print("no results")
            }
            
            // set results
            self.searchResults = results
        }
    }
    
    
}



// MARK: - Results Table View
extension MainController: NSTableViewDelegate, NSTableViewDataSource {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return searchResults.count > 1 ? searchResults.count : 0
    }
    
    
    // MARK: - Render library table cells
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let id = NSUserInterfaceItemIdentifier(rawValue: "COL")
        // get data by row index
        let result = searchResults[row]
        let cell = ResultCell()
        let license = result["license"] as? String ?? ""
        // fill in cell
        cell.identifier = id
        cell.nameText = result["name"] as? String ?? ""
        cell.descriptionText = result["description"] as? String ?? "Non-descript."
        cell.licenseText = String(license.characters.prefix(3))
        return cell
    }
    
    
    // MARK: - Push library assets view
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = resultsTable.selectedRow
        if (row != -1) {
            let result = searchResults[row]
            let name = result["name"] as? String ?? ""
            self.navigationController?.pushViewController(AssetsController(library: name))
        }
    }
    
    override func viewDidAppear() {
        self.resultsTable.deselectAll(nil)
    }
    
    
}



// MARK: - User Notifications
extension MainController: NSUserNotificationCenterDelegate {
    
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
}

