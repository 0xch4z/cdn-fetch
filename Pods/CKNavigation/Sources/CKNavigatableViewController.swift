//
//  CKNavigatable.swift
//  CKNavigation
//
//  Created by Charles Kenney on 10/16/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

open class CKNavigatableViewController: NSViewController {
    
    public var navigationController: CKNavigationController?

}

extension CKNavigatableViewController: CKNavigatable {  }
