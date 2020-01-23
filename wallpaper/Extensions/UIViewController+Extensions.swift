//
//  UIViewController+Extensions.swift
//  wallpaper
//
//  Created by Yuliia MAKOVETSKAYA on 1/23/20.
//  Copyright © 2020 Yuliia MAKOVETSKAYA. All rights reserved.
//

import UIKit

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
    
    func presentAlertWith(title: String, message: String) {
        let ac = UIAlertController(title:title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
