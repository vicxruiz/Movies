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
    var posterPath: String?
    var voteCount: Int
    var voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
    
}

