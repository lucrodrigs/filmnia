//
//  LoginViewModel.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 21/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    var resultToken: [ResultToken] = []
    var service: HTTPRequest
    var variablesToken: ResultToken?
    weak var delegate: LoginViewDelegate?
    weak var coordinatorDelegate: LoginCoordinatorDelegate?
    
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
                }
            }
        }
    }
    
    func validateForLogin(username: String, password: String) {
        let params: [String: String] = ["username":username,
                                        "password":password,
                                        "request_token":variablesToken?.requestToken ?? ""]
        
        service.validateLogin(endPoint: .urlValidateLoginAcess, params: params, type: ResultToken.self) { (result, error) in
            if let error = error {
                print("error")
                self.delegate?.erroLogin(error: error)
            } else {
                if result != nil {
                    self.createSessionForLogin(requestToken: self.variablesToken?.requestToken ?? "")
                    Session.shared.sucess = result!.success
                    self.coordinatorDelegate?.didLogin()
                }
            }
        }
    }
    
    func createSessionForLogin(requestToken: String) {
        let params: [String: String] = ["request_token":requestToken]
        service.createSession(endPoint: .urlGetSession, params: params, type: SessionInfo.self) { (result, error) in
            if let error = error {
                print("error")
                self.delegate?.erroLogin(error: error)
            } else {
                if result != nil {
                    Session.shared.sessionId = result!.sessionId
                }
            }
        }
    }

}
