//
//  FavouriteViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

protocol FavouriteViewControllerDelegate: AnyObject {
    func likeArticleAndAddToFavourite(indexOfLikedArticle: IndexPath, likedArticle: Article)
    func dislikeArticleAndRemoveFromFavourite(indexOfDislikedArticle: IndexPath)
}

class FavouriteViewController: UIViewController {
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    var favouriteArticles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        favouriteCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        guard let indexPath = favouriteCollectionView.indexPathsForSelectedItems?[0] else { return }
        
        detailViewController.selectedArticle = favouriteArticles[indexPath.row]
        detailViewController.indexOfSelectedArticle = indexPath
        if let favouriteCollectionCell = favouriteCollectionView.cellForItem(at: indexPath) as? FavouriteCollectionViewCell {
            detailViewController.currentStateOfLikeButtonOfSelectedArticle = favouriteCollectionCell.favouriteArticleCollectionLikeButton.imageView?.image
        }
        detailViewController.favouriteViewControllerDelegate = self
    }

    @IBAction func favouriteArticleLikeButtonPressed(_ sender: UIButton) {
        let likedArticleIndex = sender.tag
        let likedArticle = favouriteArticles[likedArticleIndex]
        if sender.imageView?.image == LikeButton.unpressed.image {
            sender.setImage(LikeButton.pressed.image, for: .normal)
            favouriteArticles.append(likedArticle)
            viewDidAppear(true)
        } else {
            sender.setImage(LikeButton.unpressed.image, for: .normal)
            
            if let index = favouriteArticles.firstIndex(of: likedArticle) {
                self.favouriteArticles.remove(at: index)
                viewDidAppear(true)
            }
        }
        matchFavouriteArticlesWithSavedArticles()
    }
    
    func matchFavouriteArticlesWithSavedArticles() {
        let tabBar = self.tabBarController
        guard let viewControllers = tabBar?.viewControllers else { return }
        
        for viewController in viewControllers {
            if let feedNavigationViewController = viewController as? FeedNavigationViewController {
                if let feedViewController = feedNavigationViewController.viewControllers.first as? FeedViewController {
                    feedViewController.savedArticles = self.favouriteArticles
                }
            }
        }
    }
}

extension FavouriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return favouriteArticles.count
    }
}

extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! FavouriteCollectionViewCell
        collectionCell.favouriteArticleCollectionDateLabel.text = favouriteArticles[indexPath.row].publishedAt.formateArticleDate()
            collectionCell.favouriteArticleCollectionArticleLabel.text = favouriteArticles[indexPath.row].title
            collectionCell.favouriteArticleCollectionImageView.loadImage(urlString: favouriteArticles[indexPath.row].urlToImage ?? defaultImage)
            collectionCell.favouriteArticleCollectionLikeButton.setImage(LikeButton.pressed.image, for: .normal)
            collectionCell.favouriteArticleCollectionLikeButton.tag = indexPath.row
            collectionCell.layer.cornerRadius = 20
            return collectionCell
    }
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 164, height: 191)
    }
}

extension FavouriteViewController: FavouriteViewControllerDelegate {
    func likeArticleAndAddToFavourite(indexOfLikedArticle: IndexPath, likedArticle: Article) {
        if let collectionCell = favouriteCollectionView.cellForItem(at: indexOfLikedArticle) as? FavouriteCollectionViewCell {
            collectionCell.favouriteArticleCollectionLikeButton.setImage(LikeButton.pressed.image, for: .normal)
            favouriteArticles.append(likedArticle)
            
            matchFavouriteArticlesWithSavedArticles()
        }
    }
    
    func dislikeArticleAndRemoveFromFavourite(indexOfDislikedArticle: IndexPath) {
        if let collectionCell = favouriteCollectionView.cellForItem(at: indexOfDislikedArticle) as? FavouriteCollectionViewCell {
            collectionCell.favouriteArticleCollectionLikeButton.setImage(LikeButton.unpressed.image, for: .normal)
            if let indexOfSavedArticle = favouriteArticles.firstIndex(of: favouriteArticles[indexOfDislikedArticle.row]) {
                self.favouriteArticles.remove(at: indexOfSavedArticle)
            }
            matchFavouriteArticlesWithSavedArticles()
        }
    }
}
    
