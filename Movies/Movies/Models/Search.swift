//
//  Search.swift
//  Movies
//
//  Created by Victor Ruiz on 2/1/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation

struct MovieSearch: Codable {
    var results: [MovieDB]
}

struct MovieDB: Codable {
    var poster_path: String?
    var vote_count: Int
    var vote_average: Double
}

