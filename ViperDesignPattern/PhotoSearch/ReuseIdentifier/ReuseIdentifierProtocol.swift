//
//  ReuseIdentifierProtocol.swift
//  ViperFlick
//
//  Created by Rumah Ulya on 13/04/18.
//  Copyright © 2018 Rumah Ulya. All rights reserved.
//

import UIKit

public protocol ReuseIdentifierProtocol: class {
    
    static var defaultReuseIdentifier: String {
        get
    }
}

public extension ReuseIdentifierProtocol where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
