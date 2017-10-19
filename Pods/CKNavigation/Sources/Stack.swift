//
//  Stack.swift
//  CKNavigation
//
//  Created by Charles Kenney on 10/16/17.
//  Copyright © 2017 Charles Kenney. All rights reserved.
//

import Foundation


// MARK: - Stack Helper
internal struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}
