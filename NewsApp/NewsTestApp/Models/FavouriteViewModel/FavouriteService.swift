import UIKit

final class FavouriteService {
    
    // MARK: - Public Properties
    
    static let shared = FavouriteService()
    
    var favouriteArticles = [Article]()
}
