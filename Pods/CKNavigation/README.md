<h1 align="center"><code>CKNavigationController</code></h1>
<p align="center">
  A UINavigationController port for Cocoa development
</p>

<p align="center">
  <img src="CKNavigationExample/Assets/demo.gif">
</p>

<h2>Including CKNavigation</h2>
<p>
  To integrate CKNavigation into your Xcode project using CocoaPods, specify it in your <code>Podfile</code>:
</p>

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :osx, '10.12'

target 'TargetName' do
  pod 'CKNavigation', '~> 0.1.1'
end
```

<h2>Usage</h2>
<p>
  The <code>CKNavigationController</code> is meant to provide navigation in a single <code>NSWindow</code> similar to that of UIKit's <code>UINavigationController</code> on iOS. This is a great solution for seperating views in low profile status bar apps and the like.
</p>
<p>
  Implementing a <code>CKNavigationController</code> is exactly like <code>UINavigationController</code> in iOS. Simply call the initializer and pass in the controller you'd like to set as root. Note: in order to add a view controller to a navigation controller, the view controller must subclass <a href="Sources/CKNavigatableViewController.swift"><code>CKNavigatableViewController</code> or explicitly conform to the <a href="Sources/CKNavigatable.swift"><code>CKNavigatable</code> protocol</a>.
</p>

```swift
import CKNavigation

let myController = MyViewController()
let myNavigationController = CKNavigationController(rootViewController: myController)
```

<p>
  This approach is well suited for programmatic user interfaces. You could simply create an <code>NSWindow</code> instance, and add your navigation controller as a subview.
</p>

```swift
import Foundation
import Cocoa
import CKNavigation

class AppDelegate: NSObject, NSApplicationDelegate {

    var navigationController: CKNavigationController!
    
    let controller = ViewController()
    
    let window: NSWindow {
        let content = NSRect(x: 0, y: 0, width: 500, height: 500)
        let window = NSWindow(contentRect: content, styleMask: .closable, backing: .buffered, defer: false)
        return window
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // initialize navigation controller with root view
        navigationController = CKNavigationController(rootViewController: controller)
        // add navigation controller to the window
        window.contentView?.addSubview(navigationController.view)
        navigationController.view.wantsLayer = true
        window.makeKeyAndOrderFront(nil)
    }
}
```

<p>
  Pushing a view controller to the stack is done easily, too. From inside the <code>myViewController</code> class:
</p>

```swift
    @objc func handleNextButtonPress(_ sender: Any?) {
          let newController = AnotherViewController()
          self.navigationController!.pushViewController(newController)
    }
```

<p>
  Similarly, to pop a view controller from the stack:
</p>

```swift
    @objc func handlePreviousButtonPress(_ sender: Any?) {
          self.navigationController!.popViewController()
    }
```

<h2>Example</h2>
<p>
  The example that you see in the demo gif, at the top is available <a href="CKNavigationExample">here</a>. This implementation was 100% programmatic.
</p>

<h2>License</h2>
<p>
  MIT &copy; <a href="https://github.com/charliekenney23">Charles Kenney</a>
</p>