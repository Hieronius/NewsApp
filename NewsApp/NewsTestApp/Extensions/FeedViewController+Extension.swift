//
//  FeedViewController+Extension.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 31.03.2023.
//

import Foundation

extension FeedViewController: FeedViewControllerDelegate {

    func addToSavedLikedArticle(articleIndex: IndexPath) {
        if let cell = feedTable.cellForRow(at: articleIndex) as? FeedTableViewCell {
            cell.feedArticleLikeButton.setImage(LikeButton.pressed.image, for: .normal)
        }
    }

    func removeDislikedArticleFromSaved(articleIndex: IndexPath) {
        if let cell = feedTable.cellForRow(at: articleIndex) as? FeedTableViewCell {
            cell.feedArticleLikeButton.setImage(LikeButton.unpressed.image, for: .normal)
        }
    }

}
