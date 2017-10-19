//
//  String+Utils.swift
//  CDNFetchBeta
//
//  Created by Charles Kenney on 10/19/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Regex

extension String {
    
    
    public func getFileExtension() -> String {
        let exp = Regex("\\..*$")
        let match = exp.firstMatch(in: self)
        return match?.matchedString ?? ""
    }
    
    
}
