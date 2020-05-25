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
    var resultSection: [ResultsMovies] = []
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

