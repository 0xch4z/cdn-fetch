//
//  AppDelegate.swift
//  CDN Fetch
//
//  Created by Charles Kenney on 10/19/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Cocoa
import CKNavigation

class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {

    var navigationController: CKNavigationController!
    
    
    let mainController = MainController()
    
    
    let statusItem: NSStatusItem = {
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        item.title = "Fetch"
        return item
    }()
    
    
    let popover = NSPopover()
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        popover.appearance = NSAppearance.init(named: .vibrantDark)
        popover.delegate = self
        navigationController = CKNavigationController(rootViewController: mainController)
        popover.contentViewController = navigationController
        popover.contentSize = NSSize(width: 350, height: 500)
        popover.setAccessibilityFrontmost(true)
        statusItem.action = #selector(togglePopover(_:))
    }
    
    
    @objc func togglePopover(_ sender: Any?) {
        if (popover.isShown) {
            popover.close()
        } else {
            statusItem.button!.highlight(true)
            popover.show(relativeTo: NSZeroRect, of: statusItem.button!, preferredEdge: NSRectEdge.minY)
        }
    }
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CDN_Fetch")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving and Undo support
    @IBAction func saveAction(_ sender: AnyObject?) {
        
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }
    
    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        
        return persistentContainer.viewContext.undoManager
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        return .terminateNow
    }
    
}

