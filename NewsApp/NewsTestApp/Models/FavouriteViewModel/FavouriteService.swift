//
//  FavouriteService.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 30.03.2023.
//

import UIKit

final class FavouriteService {
    
    // MARK: - Public Properties
    
    static let shared = FavouriteService()
    
    var favouriteArticles = [Article]()
}
