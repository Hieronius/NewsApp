//
//  MoscowCityBuildings.swift
//  NewsTestApp
//
//  Created by Арсентий Халимовский on 31.03.2023.
//

import Foundation

struct MoscowCityBuildings {
    
    // MARK: - Public Properties
    
    static let shared = MoscowCityBuildings()
    
    let towerUnderWater = Coordinates(latitude: 55.746854, longtitude: 37.536791)
    let eyeTowerSecond = Coordinates(latitude: 55.750457, longtitude: 37.536018)
    let nevaTower = Coordinates(latitude: 55.751133, longtitude: 37.533724)
    let eurasia = Coordinates(latitude: 55.748914, longtitude: 37.535466)
    let eyeTower = Coordinates(latitude: 55.750028, longtitude: 37.534406)
}
