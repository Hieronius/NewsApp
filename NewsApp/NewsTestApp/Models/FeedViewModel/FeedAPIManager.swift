//
//  FeedAPIManager.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 25.02.2023.
//

import UIKit

class FeedAPIManager {
    static let shared = FeedAPIManager()
     let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-02-26&to=2023-02-26&sortBy=popularity&apiKey=95b0d26c32714d8ab8936e8a9f6f9b84"
    
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


