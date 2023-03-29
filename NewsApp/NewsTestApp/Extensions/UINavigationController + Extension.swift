//
//  UINavigationController + Extension.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 29.03.2023.
//
import UIKit

extension UINavigationController {
    
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return viewControllers.first(where: { $0 is T })
    }
}
