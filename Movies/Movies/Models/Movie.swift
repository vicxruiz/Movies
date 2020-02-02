//
//  Movie.swift
//  Movies
//
//  Created by Victor Ruiz on 2/1/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var rank: Int
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case rank = "Rank"
        case id = "Id"
        case name = "Name"
    }
}

struct MovieDetails {
    var duration: String
    var description: String
    var director: String
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case duration = "Duration"
        case description = "Description"
        case director = "Director"
    }
}
