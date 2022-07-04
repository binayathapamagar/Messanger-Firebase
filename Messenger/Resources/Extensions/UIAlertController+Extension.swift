//
//  UIAlertAction+Extension.swift
//  Messenger
//
//  Created by Binaya on 04/07/2022.
//

import Foundation
import UIKit

extension UIAlertController {
    
    func addAction(title: String?, style: UIAlertAction.Style = .default, handler: (()->())? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: {_ in
            handler?()
        })
        self.addAction(action)
    }
    
}
