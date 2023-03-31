//
//  TestUser.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 31.03.2023.
//

import UIKit

struct TestUser {
    
    // MARK: - Public Properties
    
    static let shared = TestUser()
    static let user = 25
    
    let testUser = UserData(userName: "Иван",
                            userLogin: "test@mail.ru",
                            userPassword: "12345",
                            userID: 252553,
                            userTestPhoto: UIImage(named: "image 1")!)
    
}
