//
//  LoginViewModel.swift
//  filmnia
//
//  Created by UserTQI on 21/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    var resultToken: [ResultToken] = []
    var service: HTTPRequest
    var variablesToken: ResultToken?
    
    init(service: HTTPRequest = HTTPRequest()) {
        self.service = service
    }
    
    func requestTokenForLogin() {
        service.requestToken(endPoint: .urlGetToken, type: ResultToken.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if let result = result {
                    self.variablesToken = result
                    print("generate token is success")
                    print(self.variablesToken?.requestToken ?? "")
                }
            }
        }
    }
    
    func validateForLogin(username: String, password: String) {
        let params: [String: String] = ["username":username,
                                        "password":password,
                                        "request_token":variablesToken?.requestToken ?? ""]
        print(params)
        
        service.validateLogin(endPoint: .urlValidateLoginAcess, params: params, type: ResultToken.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if result != nil {
                    print("login request is success")
                    print(result ?? "")
                    self.createSessionForLogin(requestToken: self.variablesToken?.requestToken ?? "")
                }
            }
        }
    }
    
    func createSessionForLogin(requestToken: String) {
        let params: [String: String] = ["request_token":requestToken]
        print(params)
        
        service.createSession(endPoint: .urlGetSession, params: params, type: SessionInfo.self) { (result, error) in
            if error != nil {
                print("error")
            } else {
                if result != nil {
                    print("session request is sucess")
                    print(result ?? "")
                }
            }
        }
    }

}
