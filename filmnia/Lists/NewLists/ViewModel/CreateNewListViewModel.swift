//
//  CreateNewListViewModel.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 21/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

import Foundation

class CreateNewListViewModel {
    
    var service: HTTPRequest
    var yourlist: ResultList?
    var resultNewList: ResponseNewList?
    var resultsLists: [ResultList] = []
    var profileDelegate: ProfileViewDelegate?
    
    init(service: HTTPRequest = HTTPRequest()) {
        self.service = service
    }

    func createNewList(namelist: String, descriptionlist: String) {
        let params: [String: String] = ["name":namelist,
                                        "description":descriptionlist]
        
        service.createNewList(endPoint: .urlCreateNewList, params: params, idSession: Session.shared.sessionId, type: ResponseNewList.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.resultNewList = result
                }
            }
        }
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
    
}
