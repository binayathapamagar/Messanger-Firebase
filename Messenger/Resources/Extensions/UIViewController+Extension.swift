//
//  UIViewController+Extension.swift
//  Messenger
//
//  Created by Binaya on 21/06/2022.
//

import UIKit

extension UIViewController {

    func getAlert(message: String?, title: String?, style: UIAlertController.Style? = .alert) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
    }
    
    public func showErrorAlert(with title: String = "Error", and message: String = "Something went wrong!") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alertController.addAction(closeAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertWithOKActionCancel(message: String?, title: String? = "Alert",  style: UIAlertController.Style? = .alert, okTitle: String? = nil ,cancelTitle: String? = nil,okAction: (()->())? = nil) {
        let alertController = getAlert(message: message, title: title, style: style)
        alertController.addAction(title: okTitle, style: .destructive, handler: okAction)
        alertController.addAction(title: cancelTitle, style: .cancel, handler: nil)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
