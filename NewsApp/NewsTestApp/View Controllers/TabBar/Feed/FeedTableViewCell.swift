//
//  FeedTableViewCell.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 25.02.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var feedArticleImageView: UIImageView!
    @IBOutlet weak var feedArticleDateLabel: UILabel!
    @IBOutlet weak var feedArticleLabel: UILabel!
    @IBOutlet weak var feedArticleText: UILabel!
    @IBOutlet weak var feedArticleLikeButton: UIButton!
}
