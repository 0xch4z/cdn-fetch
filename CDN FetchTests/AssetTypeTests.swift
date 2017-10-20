//
//  AssetType.swift
//  CDN FetchTests
//
//  Created by Charles Kenney on 10/20/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import XCTest
@testable import CDN_Fetch

class AssetTypeTests: XCTestCase {
    
    let sampleFiles = [
        "bootstrap-materialize/styles/bootstrap-mat.min.css",
        "jquery.min.js",
        "jquery.map",
        "bootstrap.min.css",
        "file.bin",
    ]
    
    let sampleExtensions = [
        "css",
        "css",
        "bin",
        "ttf",
        "map",
        "js",
        "html"
    ]

    override func setUp() {
        super.setUp()
        print("Start: `AssertType` Tests")
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetExtensionForFileName() {
        var results: [String] = []
        let expected = [
            "css",
            "js",
            "map",
            "css",
            "bin",
        ]
        for file in self.sampleFiles {
            results.append(AssetType.getExtensionFor(fileName: file))
        }
        XCTAssert(expected == results)
    }
    
    func testGetFileTypeForExtension() {
        var results: [AssetType] = []
        let expected: [AssetType] = [
            .css,
            .css,
            .generic,
            .generic,
            .map,
            .javascript,
            .generic
        ]
        for ext in self.sampleExtensions {
            results.append(AssetType.getFileType(forExtension: ext))
        }
        XCTAssert(expected == results)
    }

}
