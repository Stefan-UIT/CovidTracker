//
//  UIViewController+Alerts.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/14/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
