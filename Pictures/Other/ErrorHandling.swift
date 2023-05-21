//
//  ErrorHandling.swift
//  Pictures
//
//  Created by Andrey on 21.05.2023.
//

import UIKit

protocol ErrorHandling {
    
    func handle(error: Error, title: String)
}

extension ErrorHandling where Self: UIViewController {
    
    func handle(error: Error, title: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(
                title: title,
                message: error.localizedDescription,
                preferredStyle: UIAlertController.Style.alert
            )
            
            alert.addAction(
                UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            )
            present(alert, animated: true, completion: nil)
        }
    }
}
