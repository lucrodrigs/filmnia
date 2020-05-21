//
//  ProfileViewModel.swift
//  filmnia
//
//  Created by UserTQI on 17/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    var service: HTTPRequest
    var delegate: ProfileViewDelegate?
    var profile: DetailsProfile?
    var yourlist: ResultList?
    var resultMovies: ResultsGeneral?
    var resultTelevision: ResultsGeneral?
    var resultsLists: [ResultList] = []
    
    init(service: HTTPRequest = HTTPRequest(), profile: DetailsProfile = DetailsProfile()) {
        self.service = service
        self.profile = profile
    }
    
    func urlPosterPath(moviePoster: Movies) -> String? {
        let urlImagePoster = moviePoster.posterPath
        return urlImagePoster
    }
    
    func getDetailsProfile() { 
        service.getProfile(endPoint: .urlGetDetailProfile, idSession: Session.shared.sessionId, type: DetailsProfile.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.profile = result
                    self.delegate?.detailsProfile()
                    Account.shared.accountId = result.id!
                }
            }
        }
    }
    
    func showFavoritesMovies() {
        service.getOptionalsProfile(endPoint: .urlGetFavoritesMovies, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResultsGeneral.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    var itens: [ResultsAllType] = []
                    for item in result.results {
                        var newItem = item
                        newItem.type = .movie
                        itens.append(newItem)
                    }
                    let newResult = ResultsGeneral(results: itens)
                    self.returnedRequestFavorites(results: newResult, type: .movie)
                }
            }
        }
    }
    
    func showFavoritesTelevision() {
        service.getOptionalsProfile(endPoint: .urlGetFavoritesTelevision, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResultsGeneral.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.returnedRequestFavorites(results: result, type: .television)
                }
            }
        }
    }
    
    func showWatchedlistMovies() {
        service.getOptionalsProfile(endPoint: .urlGetWatchedlistMovies, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResultsGeneral.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.returnedRequestFavorites(results: result, type: .movie)
                }
            }
        }
    }
    
    func showWatchedlistTelevision() {
        service.getOptionalsProfile(endPoint: .urlGetWatchedlistTelevision, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResultsGeneral.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.returnedRequestFavorites(results: result, type: .television)
                }
            }
        }
    }
    
    func showYourlists() {
        service.getListsAccount(endPoint: .urlGetYourlist, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResultList.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.yourlist = result
                    self.resultsLists.append(result)
                    self.delegate?.showLists(list: result)
                }
            }
        }
    }
    
    func returnedRequestFavorites(results: ResultsGeneral, type: MediaType) {
        switch type {
        case .television:
            resultTelevision = results
        case .movie:
            resultMovies = results
        }
        
        var response = ResultsGeneral(results: [])
        response.results.append(contentsOf: resultMovies?.results ?? [])
        response.results.append(contentsOf: resultTelevision?.results ?? [])
        delegate?.showImagePosters(resultPoster: response)
    }
    
}
