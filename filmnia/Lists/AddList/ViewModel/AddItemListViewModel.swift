//
//  AddItemList.swift
//  filmnia
//
//  Created by UserTQI on 27/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class AddItemListViewModel {
    
    var service: HTTPRequest
    var movie: Movies?
    var profileDelegate: ProfileViewDelegate?
    var delegateAlert: AlertDelegate?
    var yourlist: ResultList?
    var response: ResponseMarks?
    var resultsLists: [ResultList] = []
    
    init(service: HTTPRequest = HTTPRequest(), movies: Movies) {
        self.service = service
        self.movie = movies
    }
    
    func showYourlists() {
        service.getListsAccount(endPoint: .urlGetYourlists, idSession: Session.shared.sessionId, idAccount: Account.shared.accountId, type: ResultList.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.yourlist = result
                    self.resultsLists.append(result)
                    self.profileDelegate?.showLists(list: result)
                }
            }
        }
    }
    
    func addItemToList(selectedList: Int) {
        let params: [String: Int] = ["media_id":movie?.id ?? 0]

        service.postAddItemToList(endPoint: .urlGetDetailsList, params: params, idSession: Session.shared.sessionId, idList: selectedList, type: ResponseMarks.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.response = result
                    self.delegateAlert?.alertMarks(title: "Add to List", message: "Add " + (self.movie?.title ?? "movie") + " to List")
                }
            }
        }
    }
    
}
