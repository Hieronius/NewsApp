//
//  FeedAPIManager.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 25.02.2023.
//

import UIKit

final class FeedAPIManager {
    
    // MARK: - Public Properties
    
     static let shared = FeedAPIManager()
    
    // MARK: - Private Properties
    
    private let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-03-28&to=2023-03-28&sortBy=popularity&apiKey=95b0d26c32714d8ab8936e8a9f6f9b84"
    
    // MARK: - Public Methods
    
    func getNewsFromAPI(completion: @escaping ([Article]) -> Void) {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            if let feedData = try? JSONDecoder().decode(FeedData.self, from: data) {
                completion(feedData.articles)
            } else {
                print(error as Any)
            }
        }
        task.resume()
    }
    
}


