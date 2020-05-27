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
    var resultMark: ResponseMarks?
    var service: HTTPRequest
    
    init(service: HTTPRequest = HTTPRequest(), television: Television) {
        self.service = service
        self.television = television
    }
    
    func urlPosterPath(televisionPoster: Television) -> String? {
        let urlImagePoster = televisionPoster.posterPath
        return urlImagePoster
    }
    
    func getDetailsTelevision() {
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
    
    func markFavoriteAction() {
        let params: [String: String] = ["media_type":"tv",
                                        "media_id":String(television.id),
                                        "favorite":String(true)]
        
        service.postFavorite(endPoint: .urlGetDetailProfile, params: params, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResponseMarks.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultMark = result
                }
            }
        }
    }
    
    func markWatchedAction() {
        let params: [String: String] = ["media_type":"tv",
                                        "media_id":String(television.id),
                                        "watchlist":String(true)]
        
        service.postWatched(endPoint: .urlGetDetailProfile, params: params, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResponseMarks.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultMark = result
                    print(result)
                }
            }
        }
    }
    
    
}
