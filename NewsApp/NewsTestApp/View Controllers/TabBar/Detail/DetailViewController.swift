//
//  SpecificArticleController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 08.03.2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailArticleImageView: UIImageView!
    @IBOutlet weak var detailArticleDateLabel: UILabel!
    @IBOutlet weak var detailArticleLikeButton: UIButton!
    @IBOutlet weak var detailArticleLabel: UILabel!
    @IBOutlet weak var detailArticleText: UILabel!
    @IBOutlet weak var detailArticleView: UIView!
    
    weak var feedViewControllerDelegate: FeedViewControllerDelegate?
    weak var favouriteViewControllerDelegate: FavouriteViewControllerDelegate?
    
    var indexOfSelectedArticle: IndexPath?
    var currentStateOfLikeButtonOfSelectedArticle: UIImage?
    var selectedArticle: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpecificArticleView()
    }
    
    private func setupSpecificArticleView() {
            detailArticleImageView.layer.cornerRadius = 40
            detailArticleImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            detailArticleDateLabel.text = selectedArticle.publishedAt.formateArticleDate()
            detailArticleLabel.text = selectedArticle.title
            detailArticleText.text = selectedArticle.content
            detailArticleImageView.loadImage(urlString: selectedArticle.urlToImage ?? defaultImage)
            detailArticleLikeButton.setImage(currentStateOfLikeButtonOfSelectedArticle, for: .normal)
        }
        
    @IBAction func detailArticleLikeButtonPressed(_ sender: UIButton) {
        if sender.imageView?.image == LikeButton.unpressed.image {
            sender.setImage(LikeButton.pressed.image, for: .normal)
            feedViewControllerDelegate?.addToSavedLikedArticle(index: indexOfSelectedArticle!)
            favouriteViewControllerDelegate?.likeArticleAndAddToFavourite(indexOfLikedArticle: indexOfSelectedArticle!, likedArticle: self.selectedArticle)
        } else {
            sender.setImage(LikeButton.unpressed.image, for: .normal)
            feedViewControllerDelegate?.removeDislikedArticleFromSaved(index: indexOfSelectedArticle!)
            favouriteViewControllerDelegate?.dislikeArticleAndRemoveFromFavourite(indexOfDislikedArticle: indexOfSelectedArticle!)
        }
    }
}
