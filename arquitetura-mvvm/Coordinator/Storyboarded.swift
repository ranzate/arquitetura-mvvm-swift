//
//  Storyboarded.swift
//  arquitetura-mvvm
//
//  Created by Solutis on 4/7/19.
//  Copyright © 2019 Solutis. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(_ storyBoard: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyBoard: String) -> Self {
        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: storyBoard, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
