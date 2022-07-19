//
//  UIViewController+Extension.swift
//  SeSAC3TrendMedia
//
//  Created by 강민혜 on 7/19/22.
//

import UIKit

extension UIViewController {
    
    func background() {
        view.backgroundColor = .orange
    }
    
    func showAlert(alertTItle: String, alertMessage: String) {
        let alert = UIAlertController(title: "a", message: "b", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    
}
