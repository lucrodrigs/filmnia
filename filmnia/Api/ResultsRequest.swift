//
//  File.swift
//  donefilmlist
//
//  Created by Lucas Rodrigues Dias on 03/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

//MARK: - movies
struct ResultsMovies: Codable {
    var results: [Movies]
}

struct Movies: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let page: Int?
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case page
        case voteAverage = "vote_average"
    }
}

//MARK: - television
struct ResultsTelevision: Codable {
    var results: [Television]
}

struct Television: Codable {
    let id: Int
    let name: String
    let firstAirDate: String
    let voteAverage: Double
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}

//MARK: - DetailsMovie
struct DetailsMovie: Codable {
    let adult: Bool
    let genres: [Genre]
    let runtime: Int?
    let releaseDate: String?
    let originalTitle: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case genres
        case runtime
        case releaseDate = "release_date"
        case originalTitle = "original_title"
    }
}

//MARK: - DetailsTelevision
struct DetailsTelevison: Codable {
    let numberOfSeasons: Int
    
    enum CodingKeys: String, CodingKey {
        case numberOfSeasons = "number_of_seasons"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
