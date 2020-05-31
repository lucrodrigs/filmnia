//
//  DetailsViewModel.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 09/03/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    var movies: Movies
    var details: DetailsMovie?
    var delegate: DetailsMovieDelegate?
    var delegateAlert: AlertDelegate?
    var resultSection: [ResultsMovies] = []
    var resultMark: ResponseMarks?
    var service: HTTPRequest
    
    init(service: HTTPRequest = HTTPRequest(), movies: Movies) {
        self.service = service
        self.movies = movies
    }
    
    func urlPosterPath(moviePoster: Movies) -> String? {
        let urlImagePoster = moviePoster.posterPath
        return urlImagePoster
    }
    
    func getDetailsMovie() {
        service.requestGetDetails(endPoint: .urlDetailsMovie, id: movies.id, type: DetailsMovie.self) { (result, error) in
            if error != nil {
                    print("error")
                } else {
                    if let result = result {
                        self.details = result
                        self.delegate?.detailsMovie()
                    }
                }
            }
    }
    
    func recomendationMovies() {
        service.requestGetRecomendation(endPoint: .urlDetailsMovie, id: movies.id, type: ResultsMovies.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSection.append(result)
                    self.delegate?.showImagePosters(resultMovies: result)
                }
            }
        }
    }
    
    func markFavoriteAction() {
        let params: [String: String] = ["media_type":"movie",
                                        "media_id":String(movies.id),
                                        "favorite":String(true)]
        
        service.postFavorite(endPoint: .urlGetDetailProfile, params: params, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResponseMarks.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultMark = result
                    self.delegateAlert?.alertMarks(title: "Mark to Favorite", message: "Mark " + (self.details?.originalTitle ?? "movie") + " to Favorite")
                }
            }
        }
    }
    
    func markWatchedAction() {
        let params: [String: String] = ["media_type":"movie",
                                        "media_id":String(movies.id),
                                        "watchlist":String(true)]
        
        service.postWatched(endPoint: .urlGetDetailProfile, params: params, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResponseMarks.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultMark = result
                    self.delegateAlert?.alertMarks(title: "Mark to Watched", message: "Mark " + (self.details?.originalTitle ?? "movie") + " to Favorites")
                }
            }
        }
    }
    
}

extension Date {
    
    func toString(with format: EnumerateSection.FormatStyle) -> String {
        return toString(withFormat: format.rawValue)
    }
    
    func toString(withFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.locale = Locale.init(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
    
}

