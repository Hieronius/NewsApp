//
//  FavouriteViewControllerDelegate.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 31.03.2023.
//

import Foundation

protocol FavouriteViewControllerDelegate: AnyObject {
    
    func likeArticleAndAddToFavourite(indexOfLikedArticle: IndexPath, likedArticle: Article)
    func dislikeArticleAndRemoveFromFavourite(indexOfDislikedArticle: IndexPath)
}
