//
//  FeedViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
    func addToSavedLikedArticle(index: IndexPath)
    func removeDislikedArticleFromSaved(index: IndexPath)
}

class FeedViewController: UIViewController {
    @IBOutlet weak var feedTable: UITableView!
    
    private let numbersOfCellsInUITableViewSection = 1
    private let heightForHeaderOfTableViewSection: CGFloat = 3
    
    var savedArticles = [Article]()
    var articlesDownloadedFromAPI = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedAPIManager.shared.getNewsFromAPI { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.articlesDownloadedFromAPI = values
                self.feedTable.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        checkSavedArticlesForRemovedOnesAndUpdateItsLikeButton()
    }
    
    /// When user wan't to go back from FavouriteViewController  to the FeedViewController this method should check is article has been liked or disliked and change it's actual like button image.
    func checkSavedArticlesForRemovedOnesAndUpdateItsLikeButton() {
        var arrayOfArticlesToChange = [Int]()
        for article in articlesDownloadedFromAPI {
            if !savedArticles.contains(article) {
                arrayOfArticlesToChange.append(articlesDownloadedFromAPI.firstIndex(of: article)!)
            }
        }
        
        for index in arrayOfArticlesToChange {
            if let cell = feedTable.cellForRow(at: IndexPath(row: 0, section: index)) as? FeedTableViewCell {
                cell.feedArticleLikeButton.setImage(LikeButton.unpressed.image, for: .normal)
            }
        }
    }
    
    @IBAction func feedArticleLikeButtonPressed(_ sender: UIButton) {
        let likedArticleIndex = sender.tag
        let likedArticle = articlesDownloadedFromAPI[likedArticleIndex]
        if sender.imageView?.image == LikeButton.unpressed.image {
            sender.setImage(LikeButton.pressed.image, for: .normal)
            savedArticles.append(likedArticle)
        } else {
            sender.setImage(LikeButton.unpressed.image, for: .normal)
            if let index = savedArticles.firstIndex(of: likedArticle) {
                self.savedArticles.remove(at: index)
            }
        }
        matchSavedArticlesWithFavouriteArticles()
    }
    
    func matchSavedArticlesWithFavouriteArticles() {
        let tabBar = self.tabBarController
        guard let viewControllers = tabBar?.viewControllers else { return }
        
        for viewController in viewControllers {
            if let favouriteNaviVC = viewController as? FavouriteNavigationViewController {
                if let favouriteVC = favouriteNaviVC.viewControllers.first as? FavouriteViewController {
                    favouriteVC.favouriteArticles = self.savedArticles
                }
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        guard let indexPath = feedTable.indexPathForSelectedRow else { return }
        vc.selectedArticle = articlesDownloadedFromAPI[indexPath.section]
        vc.indexOfSelectedArticle = indexPath
        if let articleCell = feedTable.cellForRow(at: indexPath) as? FeedTableViewCell {
            vc.currentStateOfLikeButtonOfSelectedArticle = articleCell.feedArticleLikeButton.imageView?.image
        }
        vc.feedViewControllerDelegate = self
     }
}

extension FeedViewController: UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
         self.articlesDownloadedFromAPI.count
     }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return numbersOfCellsInUITableViewSection
     }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderOfTableViewSection
     }
}

extension FeedViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
         cell.feedArticleImageView.loadImage(urlString: articlesDownloadedFromAPI[indexPath.section].urlToImage ?? defaultImage)
         cell.feedArticleLikeButton.setImage(LikeButton.unpressed.image, for: .normal)
         cell.feedArticleLikeButton.tag = indexPath.section
         cell.feedArticleDateLabel.text = articlesDownloadedFromAPI[indexPath.section].publishedAt.formateArticleDate()
         cell.feedArticleLabel.text = articlesDownloadedFromAPI[indexPath.section].title
         cell.feedArticleText.text = articlesDownloadedFromAPI[indexPath.section].description
         cell.layer.cornerRadius = 25
         return cell
    }
}

extension FeedViewController: FeedViewControllerDelegate {
    func addToSavedLikedArticle(index: IndexPath) {
        if let cell = feedTable.cellForRow(at: index) as? FeedTableViewCell {
            cell.feedArticleLikeButton.setImage(LikeButton.pressed.image, for: .normal)
            savedArticles.append(articlesDownloadedFromAPI[index.section])
            matchSavedArticlesWithFavouriteArticles()
        }
    }
    
    func removeDislikedArticleFromSaved(index: IndexPath) {
        if let cell = feedTable.cellForRow(at: index) as? FeedTableViewCell {
            cell.feedArticleLikeButton.setImage(LikeButton.unpressed.image, for: .normal)
            
            if let indexOfSavedArticle = savedArticles.firstIndex(of: articlesDownloadedFromAPI[index.section]) {
                self.savedArticles.remove(at: indexOfSavedArticle)
                matchSavedArticlesWithFavouriteArticles()
            }
        }
    }
}
