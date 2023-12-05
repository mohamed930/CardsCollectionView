//
//  UIViewController.swift
//  myCards
//
//  Created by Mohamed Ali on 06/12/2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,describtion: String) {
        let alert = UIAlertController(title: title, message: describtion, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        self.present(alert, animated: true)
    }
}
