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

class FavoritesCotnroller: CKNavigatableViewController {
    
    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer!.backgroundColor = CGColor.black
    }
    
}
