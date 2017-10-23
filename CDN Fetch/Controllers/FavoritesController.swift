//
//  FavoritesController.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/18/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import CKNavigation
import Cocoa

class FavoritesController: CKNavigatableViewController {
    
    
    var favorites: [FavoriteAsset] = [] {
        didSet {
            favoritesTable.reloadData()
        }
    }
    
    
    let header: NavigationHeader = {
        let header = NavigationHeader()
        header.headingLabel.stringValue = "Favorites"
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
    
    
    let favoritesTable: NSTableView = {
        let table = NSTableView()
        table.rowHeight = 50
        table.wantsLayer = false
        table.headerView = nil
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    let column: NSTableColumn = {
        let col = NSTableColumn()
        col.identifier = .assetColumn
        return col
    }()
    
    
    override func loadView() {
        self.view = NSView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupHeader()
        setupFavoritesTable()
        fetchFavorites()
    }
    
    
    func setupView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        self.view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        self.view.wantsLayer = true
    }
    
    
    func addViews() {
        self.view.addSubview(header)
        self.view.addSubview(scrollView)
    }
    
    
    func setupHeader() {
        header.backButton.target = self
        header.backButton.action = #selector(goBack(_:))
        header.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        header.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    // MARK: - Setup table and add constraints
    func setupFavoritesTable() {
        favoritesTable.addTableColumn(column)
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
        scrollView.documentView = favoritesTable
        scrollView.contentView.drawsBackground = false
        scrollView.hasVerticalScroller = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
}



// MARK: - Table View
extension FavoritesController: NSTableViewDelegate, NSTableViewDataSource {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // get favorite item
        let item = favorites[row]
        // create cell
        let cell = FavoriteCell()
        cell.identifier = .assetRow
        cell.assetName = item.name ?? ""
        cell.library = item.library ?? ""
        cell.version = item.version ?? ""
        cell.fetchButton.tag = row
        return cell
    }
    
    
}



// MARK: - Core Data calls
extension FavoritesController {
    

    func fetchFavorites() {
        guard let delegate = NSApplication.shared.delegate as? AppDelegate else {
            print("could not get delegate")
            return
        }
        
        let context = delegate.persistentContainer.viewContext
        
        do {
            favorites = try context.fetch(FavoriteAsset.fetchRequest())
        } catch let error {
            print("error getting favorites: \(error)")
        }
    }
    
    
}



// MARK: - Actions
extension FavoritesController {
    
    
    @objc func goBack(_ sender: Any?) {
        self.navigationController?.popViewController()
    }
    
}
