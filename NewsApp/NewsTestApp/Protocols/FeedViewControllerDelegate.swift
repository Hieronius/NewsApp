//
//  FeedViewControllerDelegate.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 31.03.2023.
//

import Foundation

protocol FeedViewControllerDelegate: AnyObject {
    
    func addToSavedLikedArticle(articleIndex: IndexPath)
    func removeDislikedArticleFromSaved(articleIndex: IndexPath)
}
