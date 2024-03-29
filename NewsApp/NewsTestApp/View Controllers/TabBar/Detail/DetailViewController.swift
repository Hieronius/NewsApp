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
    
    var indexOfSelectedArticle: IndexPath?
    var currentStateOfLikeButtonOfSelectedArticle: UIImage?
    var currentUIStateOfLikeButtonOfSelectedArticle = false
    var selectedArticle: Article!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpecificArticleView()
    }
    
    // MARK: - IBActions
        
    @IBAction func detailArticleLikeButtonPressed(_ sender: UIButton) {
        if !sender.isSelected {
            FavouriteService.shared.favouriteArticles.append(selectedArticle)
            sender.isSelected.toggle()
            
        } else {
            if let index = FavouriteService.shared.favouriteArticles.firstIndex(of: selectedArticle) {
                FavouriteService.shared.favouriteArticles.remove(at: index)
                sender.isSelected = false
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupSpecificArticleView() {
        detailArticleImageView.layer.cornerRadius = 40
        detailArticleImageView.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                                      .layerMinXMaxYCorner]
        detailArticleDateLabel.text = selectedArticle.publishedAt?.formateArticleDate()
        detailArticleLabel.text = selectedArticle.title
        detailArticleText.text = selectedArticle.content
        detailArticleImageView.loadImage(urlString: selectedArticle.urlToImage ?? ImageService.defaultImage)
        detailArticleLikeButton.setImage(LikeButton.unpressed.image, for: .normal)
        detailArticleLikeButton.setImage(LikeButton.pressed.image, for: .selected)
        
        if currentUIStateOfLikeButtonOfSelectedArticle {
            detailArticleLikeButton.isSelected = true
        }
    }
    
}
