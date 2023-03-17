//
//  LikeButton.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 16.03.2023.
//

import UIKit

enum LikeButton {
    case unpressed
    case pressed
    
    var image: UIImage {
        switch self {
        case .unpressed: return UIImage(named: "like")!
        case .pressed: return UIImage(named: "likePressed")!
        }
    }
}

