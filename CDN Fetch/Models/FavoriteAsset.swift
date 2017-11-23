//
//  FavoriteAsset.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/20/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import CoreData

class FavoriteAsset: NSManagedObject {

//    return AssetType(rawValue: self.typeState)

    var type: AssetType? {
        get {
            return AssetType(rawValue: self.typeState)
        }
        set {
            if let newState = newValue?.rawValue {
                self.typeState = newState
            }
        }
    }

}

extension FavoriteAsset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteAsset> {
        return NSFetchRequest<FavoriteAsset>(entityName: "FavoriteAsset")
    }

    @NSManaged public var library: String?
    @NSManaged public var name: String?
    @NSManaged public var typeState: Int16
    @NSManaged public var uri: String?
    @NSManaged public var version: String?

}
