//
//  File.swift
//  filmnia
//
//  Created by UserTQI on 30/03/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

protocol SearchViewDelegate {
    func showImagePosters(resultPoster: ResultsMovies)
}

class SearchViewModel {
    
    var resultSection: [ResultsMovies] = []
    var delegate: SearchViewDelegate?
    var service: HTTPRequest
    
    init(service: HTTPRequest = HTTPRequest()) {
        self.service = service
        searchQuery = ""
    }
    
    var searchQuery: String {
          didSet {
            reloadSearch()
          }
      }
    
    func urlPosterPath(moviePoster: Movies) -> String? {
        let urlImagePoster = moviePoster.posterPath
        return urlImagePoster
    }
    
    func reloadSearch() {
        if !searchQuery.isEmpty {
            resultSearchMovies(query: searchQuery)
        }
    }
            
    func resultSearchMovies(query: String) {
        service.requestGetSearch(endPoint: .urlSearchMovies, query: query, type: ResultsMovies.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSection.append(result)
                    self.delegate?.showImagePosters(resultPoster: result)
                }
            }
        }
    }
    
    func resultInitializerPopularMovies() {
        service.requestGet(endPoint: .urlPopularMovie, type: ResultsMovies.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSection.append(result)
                    self.delegate?.showImagePosters(resultPoster: result)
                }
            }
        }
    }
    
}
