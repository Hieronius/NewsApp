//
//  UserData.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 14.03.2023.
//

import UIKit

struct UserData {
    var userName: String
    var userLogin: String
    var userPassword: String
    var userID: Int
    var userTestPhoto: UIImage
}

var testUser = UserData(userName: "Иван",
                        userLogin: "test@mail.ru",
                        userPassword: "12345",
                        userID: 252553,
                        userTestPhoto: UIImage(named: "image 1")!)
                        
