//
//  SettingWindow.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/20/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

class SettingsWindow: NSWindow {
    
    
    convenience init() {
        let rect = NSRect(x: 0, y: 0, width: 500, height: 500)
        self.init(contentRect: rect, styleMask: .closable, backing: .buffered, defer: false)
        self.isReleasedWhenClosed = false
        setupWindow()
    }
    
    
    func setupWindow() {
        self.centerFrameToScreen()
        self.appearance = NSAppearance(named: .vibrantDark)
        self.styleMask = [.titled, .closable, .miniaturizable]
        self.isOpaque = false
        self.titlebarAppearsTransparent = true
        self.title = "CDN Fetch Settings"
    }
    
}
