//
//  CKNavigatable.swift
//  CKNavigation
//
//  Created by Charles Kenney on 10/16/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

public protocol CKNavigatable {
    
    var navigationController: CKNavigationController? { get set }
    
}


public extension CKNavigatable {
    
    mutating func setNavigationController(to navigationController: CKNavigationController) {
        self.navigationController = navigationController
    }
    
}
