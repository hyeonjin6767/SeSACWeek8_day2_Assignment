//
//  AlertExtension.swift
//  SeSACWeek8_day2_Assignment
//
//  Created by 박현진 on 8/21/25.
//

import Foundation

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, ok: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: ok, style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
