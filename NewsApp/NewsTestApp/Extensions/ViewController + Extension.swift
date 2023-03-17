//
//  ViewController + Extension.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 24.02.2023.
//

import UIKit

extension UIViewController {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
