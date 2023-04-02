//
//  FeedViewController.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 23.02.2023.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var feedTable: UITableView!
    
    // MARK: - Public Properties
    
    var articlesDownloadedFromAPI = [Article]()
    
    // MARK: - Lifecycle
    
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
    
    // MARK: - Public Methods
    
    /// When user wan't to go back from FavouriteViewController or DetailViewController to the FeedViewController this method should check is article has been liked or disliked and change it's actual like button image.
    func checkSavedArticlesForRemovedOnesAndUpdateItsLikeButton() {
        var arrayOfDislikeButtons = [Int]()
        var arrayOfLikeButtons = [Int]()
        for article in articlesDownloadedFromAPI {
            if !FavouriteService.shared.favouriteArticles.contains(article) {
                arrayOfDislikeButtons.append(articlesDownloadedFromAPI.firstIndex(of: article)!)
            } else {
                arrayOfLikeButtons.append(articlesDownloadedFromAPI.firstIndex(of: article)!)
            }
        }
        for index in arrayOfDislikeButtons {
            if let cell = feedTable.cellForRow(at: IndexPath(row: index, section: 0)) as? FeedTableViewCell {
                    cell.feedArticleLikeButton.isSelected = false
            }
        }
        for index in arrayOfLikeButtons {
            if let cell = feedTable.cellForRow(at: IndexPath(row: index, section: 0)) as? FeedTableViewCell {
                cell.feedArticleLikeButton.isSelected = true
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        guard let indexPath = feedTable.indexPathForSelectedRow else { return }
        
        detailViewController.selectedArticle = articlesDownloadedFromAPI[indexPath.row]
        detailViewController.indexOfSelectedArticle = indexPath
        if let articleCell = feedTable.cellForRow(at: indexPath) as? FeedTableViewCell {
            detailViewController.currentUIStateOfLikeButtonOfSelectedArticle = articleCell.feedArticleLikeButton.isSelected
        }
     }
    
    // MARK: - IBActions
    
    @IBAction func feedArticleLikeButtonPressed(_ sender: UIButton) {
        let likedArticleIndex = sender.tag
        let likedArticle = articlesDownloadedFromAPI[likedArticleIndex]
        if !sender.isSelected {
            FavouriteService.shared.favouriteArticles.append(likedArticle)
            sender.isSelected.toggle()
            
        } else {
            if let index = FavouriteService.shared.favouriteArticles.firstIndex(of: likedArticle) {
                FavouriteService.shared.favouriteArticles.remove(at: index)
                sender.isSelected = false
            }
        }
    }
        
}

// MARK: - Extensions

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return articlesDownloadedFromAPI.count
     }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
         cell.feedArticleImageView.loadImage(urlString: articlesDownloadedFromAPI[indexPath.row].urlToImage ?? ImageService.defaultImage)
         cell.feedArticleLikeButton.setImage(LikeButton.unpressed.image, for: .normal)
         cell.feedArticleLikeButton.setImage(LikeButton.pressed.image, for: .selected)
         cell.feedArticleLikeButton.tag = indexPath.row
         cell.feedArticleDateLabel.text = articlesDownloadedFromAPI[indexPath.row].publishedAt.formateArticleDate()
         cell.feedArticleLabel.text = articlesDownloadedFromAPI[indexPath.row].title
         cell.feedArticleText.text = articlesDownloadedFromAPI[indexPath.row].description
         cell.layer.cornerRadius = 25
         cell.feedCellView.layer.cornerRadius = 25
         
         let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
         cell.selectedBackgroundView = backgroundView
         return cell
    }
}
