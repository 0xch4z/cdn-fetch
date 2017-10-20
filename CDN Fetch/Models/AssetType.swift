//
//  AssetType.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/19/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation

enum AssetType {
    case javascript
    case css
    case map
    case generic
    
    public static func getExtensionFor(fileName: String) -> String {
        let ext = fileName.split(separator: ".").last ?? ""
        return String(ext)
    }
    
    public static func getFileType(forExtension ext: String) -> AssetType {
        switch (ext) {
        case "js", "jsx":
            return .javascript
        case "css":
            return .css
        case "map":
            return .map
        default:
            return .generic
        }
    }
}
