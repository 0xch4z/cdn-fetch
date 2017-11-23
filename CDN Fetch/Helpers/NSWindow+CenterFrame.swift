//
//  NSWindow+CenterFrame.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/20/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import Cocoa

extension NSWindow {

    public func centerFrameToScreen() {
        if let screenSize = screen?.frame.size {
            let centerX = (screenSize.width - self.frame.size.width) / 2
            let centerY = (screenSize.height - self.frame.size.height) / 2
            let center = NSPoint(x: centerX, y: centerY)
            self.setFrameOrigin(center)
        }
    }

}
