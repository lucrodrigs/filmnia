//
//  File.swift
//  filmnia
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
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
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
    let voteAverage: Float
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

//MARK: - general
struct ResultsGeneral: Codable {
    var results: [ResultsAllType]
}

struct ResultsAllType: Codable {
    let id: Int?
    let title: String?
    let name: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let firstAirDate: String?
    let page: Int?
    let voteAverage: Float?
    var type: MediaType?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case page
        case voteAverage = "vote_average"
        case type
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
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case numberOfSeasons = "number_of_seasons"
        case genres
    }
}

//MARK: - MultiSearch
struct ResultsSearch {
    var results: [MultiSearch]
}

struct MultiSearch: Codable {
    let mediaType: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case id
    }
}

//MARK: - Genres
struct Genre: Codable {
    let id: Int
    let name: String
}

//MARK: - RequestTokenLogin
struct ResultToken: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

//MARK: - AccountSession
struct SessionInfo: Codable {
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}

class Session {
    static let shared = Session()
    var sessionId = ""
    var sucess = false
}

//MARK: - DetailsProfile
struct DetailsProfile: Codable {
    var avatar: Avatar?
    var id: Int?
    var name: String?
    var username: String?

    enum CodingKeys: String, CodingKey {
        case avatar
        case id
        case name
        case username
    }
}

class Account {
    static let shared = Account()
    var accountId: Int = 0
}

struct Avatar: Codable {
    let gravatar: Gravatar?
}

struct Gravatar: Codable {
    let hash: String?
}

//MARK: - ListAccount
struct ResultList: Codable {
    let results: [List]
}

struct List: Codable {
    let name: String?
    let resultDescription: String?
    let id: Int?
    let itensCount: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case resultDescription = "description"
        case id
        case itensCount = "item_count"
    }
}

//MARK: - DetailsListAccount
struct DetailsList: Codable {
    let name: String
    let description: String
    let id: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case name
        case description = "description"
        case id
        case items
    }
}

struct Item: Codable {
    let id: Int?
    let mediaType: MediaType?
    let name: String?
    let voteAverage: Float?
    let firstAirDate: String?
    let posterPath: String?
    let overview: String?
    let title: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case name
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case overview
        case title
        case releaseDate = "release_date"
    }
}

//MARK: - ResponseCreateNewList
struct ResponseNewList: Codable {
    let statusMessage: String
    let success: Bool
    let listID: Int

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case success
        case listID = "list_id"
    }
}

//MARK: - ResponseMarks
struct ResponseMarks: Codable {
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
    }
}
