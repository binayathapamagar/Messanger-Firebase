//
//  UIViewController+Extension.swift
//  Messenger
//
//  Created by Binaya on 21/06/2022.
//

import UIKit

extension UIViewController {

    public func showErrorAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
