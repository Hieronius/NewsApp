//
//  String + extension.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 15.03.2023.
//

import Foundation

extension String {
    /// With this method we wan't cut date label by 10 symbols to make it clean and concise
    func formateArticleDate() -> String {
        let maxLenght = 10
        let result = String(self.prefix(maxLenght))
        return result
        
    }
}
 
