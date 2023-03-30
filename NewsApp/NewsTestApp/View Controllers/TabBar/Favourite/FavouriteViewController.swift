//
//  FavouriteViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

final class FavouriteViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        favouriteCollectionView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        guard let indexPath = favouriteCollectionView.indexPathsForSelectedItems?[0] else { return }
        
        detailViewController.selectedArticle = FavouriteService.shared.favouriteArticles[indexPath.row]
        detailViewController.indexOfSelectedArticle = indexPath
        if let favouriteCollectionCell = favouriteCollectionView.cellForItem(at: indexPath) as? FavouriteCollectionViewCell {
            detailViewController.currentStateOfLikeButtonOfSelectedArticle = favouriteCollectionCell.favouriteArticleCollectionLikeButton.imageView?.image
        }
        detailViewController.favouriteViewControllerDelegate = self
    }
    
    // MARK: - IBActions

    @IBAction func favouriteArticleLikeButtonPressed(_ sender: UIButton) {
        
        let likedArticleIndex = sender.tag
        let likedArticle = FavouriteService.shared.favouriteArticles[likedArticleIndex]
        if sender.imageView?.image == LikeButton.unpressed.image {
            sender.setImage(LikeButton.pressed.image, for: .normal)
            FavouriteService.shared.favouriteArticles.append(likedArticle)
            viewDidAppear(true)
        } else {
            sender.setImage(LikeButton.unpressed.image, for: .normal)
            
            if let index = FavouriteService.shared.favouriteArticles.firstIndex(of: likedArticle) {
                FavouriteService.shared.favouriteArticles.remove(at: index)
                viewDidAppear(true)
            }
        }
    }
    
}

// MARK: - Extensions

// MARK: - UICollectionViewDelegate

extension FavouriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavouriteService.shared.favouriteArticles.count
    }
}

// MARK: - UICollectionViewDataSource

extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! FavouriteCollectionViewCell
         
        collectionCell.favouriteArticleCollectionDateLabel.text = FavouriteService.shared.favouriteArticles[indexPath.row].publishedAt.formateArticleDate()
        collectionCell.favouriteArticleCollectionArticleLabel.text = FavouriteService.shared.favouriteArticles[indexPath.row].title
        collectionCell.favouriteArticleCollectionImageView.loadImage(urlString: FavouriteService.shared.favouriteArticles[indexPath.row].urlToImage ?? defaultImage)
            collectionCell.favouriteArticleCollectionLikeButton.setImage(LikeButton.pressed.image, for: .normal)
            collectionCell.favouriteArticleCollectionLikeButton.tag = indexPath.row
            collectionCell.layer.cornerRadius = 20
            return collectionCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.44, height: height * 0.23)
    }
}
