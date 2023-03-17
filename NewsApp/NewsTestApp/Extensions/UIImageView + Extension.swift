//
//  UIImageView + Extension.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 28.02.2023.
//

import UIKit


extension UIImageView {
    
    /// Load image from API web-adress
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
