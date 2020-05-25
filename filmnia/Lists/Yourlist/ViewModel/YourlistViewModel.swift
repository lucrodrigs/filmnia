//
//  YourlistViewModel.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 12/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class YourlistViewModel {
    
    var service: HTTPRequest
    var detailslist: DetailsList?
    var delegate: DetailsListDelegate?
    var list: List?
    
    init(service: HTTPRequest = HTTPRequest(), list: List) {
        self.service = service
        self.list = list
    }

    func getDetailsList() {
        service.getDetailsYourlists(endPoint: .urlGetYourlist, idList: list?.id ?? 0, type: DetailsList.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.detailslist = result
                    self.delegate?.showImagePosters(resultPoster: result)
                    self.delegate?.detailsList()
    
                    print(result)
                }
            }
        }
    }
    
}
