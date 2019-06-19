//
//  ErrorExtension.swift
//  NYCSchools-MuhammadShoukat
//
//  Created by Asad Ali on 6/16/19.
//  Copyright © 2019 Muhammad Shoukat. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func showAlert(massage : String, errTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: errTitle, message: massage, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: handler)
        
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}


