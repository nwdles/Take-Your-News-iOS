//
//  Favorites.swift
//  Take-Your-News
//
//  Created by Anastasiya on 21/05/2020.
//  Copyright © 2020 Anastasiya. All rights reserved.
//

import Foundation

struct FavoritesList: Decodable {
    var data: [FavoriteCategory]?
}

struct FavoriteCategory: Decodable {
    let name: String
    let image: String?
    var publications: [FavoritePublication]?
}

struct FavoritePublication: Decodable {
    let header: String
    let description: String
    let text: String
    let image: String?
}
