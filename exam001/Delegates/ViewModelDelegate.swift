//
//  ViewModelDelegate.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

import UIKit

protocol ViewModelDelegate: class {
    
    // adnan:
    // className
    // Case 1: doesn't pass or return objects (ex: viewControllerDidUpdateData(_ viewController: ViewController))
    // Case 2: pass object and has no return value (ex: viewController(_ viewController: ViewController, didAddDataAtIndex index: Int))
    // func viewController(_ viewController: ViewController, didAddDataAt index: Int)
    // func numberOfItems() -> Int // Case 3: has return value and no parameters.
    // func viewController(_ viewController: ViewController, heightForItemAt index: Int) -> CGFloat // Case 4: has parameter and return value
    
    func viewControllerDidUpdateData(_ viewController: ViewController)
    func viewController(_ viewController: ViewController, didAddDataAt index: Int)
}
