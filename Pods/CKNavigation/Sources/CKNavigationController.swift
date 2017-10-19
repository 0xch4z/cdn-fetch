//
//  CKNavigationController.swift
//  CKNavigation
//
//  Created by Charles Kenney on 10/14/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation
import CoreGraphics
import Cocoa


/**
 Type for `NSViewController` instances that conform to the `Navigatable` protocol.
 Navigatable Controllers can be pushed and popped from `CKNavigationController.rootViewController`
 */
public typealias NavigatableViewController = NSViewController & CKNavigatable


/**
 Type for `Stack` of `NavigatableViewController`s
 */
internal typealias NavigatableViewControllerStack = Stack<NavigatableViewController>


/**
 A controller that manages a stack of `NavigatableViewController`s, loaded from a nib or storyboard.
 Initialized with a single root view controller of type: `NavigatableViewController`.
 View controllers can be dynamically pushed and popped from the stack, but the root *will* always remain.
 @todo: Add animation and integrate `CKNavigationBar`
 @todo: Add `CKNavigationBar` and customization
 */
open class CKNavigationController: NSViewController, NSWindowDelegate {
    
    /**
     The container view that holds the `topViewController`.
     */
    var container = NSView()
    
    
    /**
     The view controller that is currently key and visible.
     */
    private var topViewController: NavigatableViewController? {
        didSet {
            // setup top view controller
            if let tvc = topViewController {
                setupController(controller: tvc)
            }
        }
    }
    
    
    /**
     The stack of view controllers pushed and popped from the root view controller.
     */
    private var viewControllerStack = NavigatableViewControllerStack()
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // setup container
        print("test2")
        setupContainer()
    }
    
    
    open override func loadView() {
        // setup view
        self.view = NSView()
        print("loaded navigation view")
    }
    
    
    /**
     Pushes an instance of `NavigatableViewController` to the `viewControllerStack`
     - parameters:
       - controller: The view controller to push to the navigation stack
     */
    open func pushViewController(_ controller: NavigatableViewController) {
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.completionHandler = {
            // push to stack
            self.viewControllerStack.push(controller)
            // add child view controller
            self.addChildViewController(controller)
            // update current view controller
            self.topViewController = self.viewControllerStack.top
        }
        NSAnimationContext.current.duration = 0.3
        NSAnimationContext.current.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        var origin = self.topViewController!.view.frame.origin
        origin.x -= 1000
        self.topViewController!.view.animator().setFrameOrigin(origin)
        NSAnimationContext.endGrouping()
    }
    
    
    /**
     Pops the `topViewController` off the `viewControllerStack`
     @todo: Allow custom animation
     */
    open func popViewController() {
        if (viewControllerStack.count > 1) {
            NSAnimationContext.beginGrouping()
            NSAnimationContext.current.completionHandler = {
                // pop from stack
                _ = self.viewControllerStack.pop()
                // set previous view controller
                self.topViewController = self.viewControllerStack.top
            }
            NSAnimationContext.current.duration = 0.3
            NSAnimationContext.current.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            var origin = self.topViewController!.view.frame.origin
            origin.x += 1000
            self.topViewController!.view.animator().setFrameOrigin(origin)
            NSAnimationContext.endGrouping()
        }
    }
    
    
    /**
     Pops all the view controllers in the `viewControllerStack` until the root view controller
     is surfaced.
     */
    public func popToRootViewController() {
        while (viewControllerStack.count > 1) {
            popViewController()
        }
    }
    
    
    /**
     Sets up constraints for the container view
     */
    open func setupContainer() {
        // add to view controller
        self.view.addSubview(container)
        // setup constraints
        container.translatesAutoresizingMaskIntoConstraints = false
        container.fitView(to: self.view)
    }
    
    
    /**
     Prepares controller for setting as `topViewController`
     - parameters:
       - controller: Controller to prepare
     */
    private func setupController(controller: NavigatableViewController) {
        // remove all current views
        for subview in self.container.subviews {
            subview.removeFromSuperview()
        }
        // add root view controller to subview
        container.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.fitView(to: container)
        var ptr = controller
        ptr.setNavigationController(to: self)
    }
    
    public convenience init(rootViewController controller: NavigatableViewController) {
        self.init()
        setRootViewController(controller)
    }
    
    /**
     A helper method for setting the root view controller
     - parameters:
       - controller: Controller to set as root
     */
    public func setRootViewController(_ controller: NavigatableViewController) {
        // push to stack
        viewControllerStack.push(controller)
        // update top view
        topViewController = controller
    }
    
    
}


// MARK: - NSView Helpers
fileprivate extension NSView {
    
    
    /**
     Fits a child view to the exact frame of a parent view
     - parameters:
       - parent: The superview to constrain to
     */
    func fitView(to parent: NSView) {
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: parent.heightAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
    }
    
    
}
