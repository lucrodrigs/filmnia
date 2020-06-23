//
//  HomeViewModel.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 18/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var delegate: HomeViewDelegate?
    var resultSectionMovies: [ResultsMovies] = []
    var resultSectionTelevision: [ResultsTelevision] = []
    var service: HTTPRequest
    
    init(service: HTTPRequest = HTTPRequest()) {
        self.service = service
    }
    
    func urlPosterPath(moviePoster: Movies) -> String? {
        let urlImagePoster = moviePoster.posterPath
        return urlImagePoster
    }
    
    func resultPosterGetMoviesPopulars() {
        service.requestGet(endPoint: .urlPopularMovie, type: ResultsMovies.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSectionMovies.append(result)
                    self.delegate?.showImagePosters(resultPoster: .moviesPopular(result))
                }
            }
        }
    }
    
    func resultPosterGetUpComing() {
        service.requestGet(endPoint: .urlUpComingMovie, type: ResultsMovies.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSectionMovies.append(result)
                    self.delegate?.showImagePosters(resultPoster: .moviesUpComing(result))
                }
            }
        }
    }
    
    func resultPosterNowPlaying() {
        service.requestGet(endPoint: .urlNowPlayingMovie, type: ResultsMovies.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSectionMovies.append(result)
                    self.delegate?.showImagePosters(resultPoster: .moviesNowPlaying(result))
                }
            }
        }
    }
    
    func resultPosterGetTvPopulars() {
        service.requestGet(endPoint: .urlPopularTv, type: ResultsTelevision.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSectionTelevision.append(result)
                    self.delegate?.showImagePosters(resultPoster: .televisionPopular(result))
                }
            }
            
        }
    }
    
    func resultPosterGetTopRated() {
        service.requestGet(endPoint: .urlTopRatedTv, type: ResultsTelevision.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSectionTelevision.append(result)
                    self.delegate?.showImagePosters(resultPoster: .televisionTopRated(result))
                }
            }
            }
    }
    
    func resultPosterGetOnTheAir() {
        service.requestGet(endPoint: .urlOnTheAir, type: ResultsTelevision.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultSectionTelevision.append(result)
                    self.delegate?.showImagePosters(resultPoster: .televisionOnTheAir(result))
                }
            }
        }
    }
    
}
