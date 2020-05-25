//
//  File.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 14/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class DetailsTelevisionViewModel {
    
    var television: Television
    var details: DetailsTelevison?
    var delegate: DetailsTelevisionDelegate?
    var resultSection: [ResultsTelevision] = []
    var service: HTTPRequest
    
    init(service: HTTPRequest = HTTPRequest(), television: Television) {
        self.service = service
        self.television = television
    }
    
    func urlPosterPath(televisionPoster: Television) -> String? {
        let urlImagePoster = televisionPoster.posterPath
        return urlImagePoster
    }
    
    func detailsTelevision() {
        service.requestGetDetails(endPoint: .urlDetailsTelevision, id: television.id, type: DetailsTelevison.self) { (result, error) in
            if error != nil {
                    print("error")
                } else {
                    if let result = result {
                        self.details = result
                        self.delegate?.detailsTelevision()
                    }
                }
            }
    }
    
    func recomendationTelevision() {
        service.requestGetRecomendation(endPoint: .urlDetailsTelevision, id: television.id, type: ResultsTelevision.self) { (result, error) in
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
