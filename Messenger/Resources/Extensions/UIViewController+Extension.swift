//
//  UIViewController+Extension.swift
//  Messenger
//
//  Created by Binaya on 21/06/2022.
//

import UIKit

extension UIViewController {

    public func showErrorAlert(with title: String = "Error", and message: String = "Something went wrong!") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
