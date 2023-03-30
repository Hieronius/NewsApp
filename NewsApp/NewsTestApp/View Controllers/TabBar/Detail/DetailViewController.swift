//
//  SpecificArticleController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 08.03.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var detailArticleImageView: UIImageView!
    @IBOutlet private weak var detailArticleDateLabel: UILabel!
    @IBOutlet private weak var detailArticleLikeButton: UIButton!
    @IBOutlet private weak var detailArticleLabel: UILabel!
    @IBOutlet private weak var detailArticleText: UILabel!
    @IBOutlet private weak var detailArticleView: UIView!
    
    // MARK: - Public Properties
    
    weak var feedViewControllerDelegate: FeedViewControllerDelegate?
    weak var favouriteViewControllerDelegate: FavouriteViewControllerDelegate?
    
    var indexOfSelectedArticle: IndexPath?
    var currentStateOfLikeButtonOfSelectedArticle: UIImage?
    var selectedArticle: Article!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpecificArticleView()
    }
    
    // MARK: - IBActions
        
    @IBAction func detailArticleLikeButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image == LikeButton.unpressed.image {
            sender.setImage(LikeButton.pressed.image, for: .normal)
            feedViewControllerDelegate?.addToSavedLikedArticle(articleIndex: indexOfSelectedArticle!)
            favouriteViewControllerDelegate?.likeArticleAndAddToFavourite(indexOfLikedArticle: indexOfSelectedArticle!, likedArticle: self.selectedArticle)
        } else {
            sender.setImage(LikeButton.unpressed.image, for: .normal)
            feedViewControllerDelegate?.removeDislikedArticleFromSaved(articleIndex: indexOfSelectedArticle!)
            favouriteViewControllerDelegate?.dislikeArticleAndRemoveFromFavourite(indexOfDislikedArticle: indexOfSelectedArticle!)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupSpecificArticleView() {
            detailArticleImageView.layer.cornerRadius = 40
            detailArticleImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            detailArticleDateLabel.text = selectedArticle.publishedAt.formateArticleDate()
            detailArticleLabel.text = selectedArticle.title
            detailArticleText.text = selectedArticle.content
            detailArticleImageView.loadImage(urlString: selectedArticle.urlToImage ?? defaultImage)
            detailArticleLikeButton.setImage(currentStateOfLikeButtonOfSelectedArticle, for: .normal)
        }
    
}
