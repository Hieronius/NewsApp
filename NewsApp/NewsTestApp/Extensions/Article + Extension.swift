//
//  Article + Extension.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 14.03.2023.
//

import Foundation

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
}
