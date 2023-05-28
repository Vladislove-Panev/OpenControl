//
//  UIViewController+Extensions.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import UIKit

extension UIViewController {
    func showErrorAlert(error: Error) {
        let alertVC = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true)
    }
}
