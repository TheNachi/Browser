//
//  BaseViewController.swift
//  Browser
//
//  Created by Munachimso Ugorji on 28/03/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func correctDisplayAlert(title: String?, message: String?,
        actions: [UIAlertAction] = [],
        preferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if actions.isEmpty {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
        } else {
            actions.forEach { (action) in
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
}
