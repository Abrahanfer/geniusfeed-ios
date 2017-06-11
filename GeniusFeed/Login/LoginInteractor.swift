//
//  LoginInteractor.swift
//  GeniusFeed
//
//  Created by Abrahán Fernández Nieto on 19/4/17.
//  Copyright © 2017 Abrahanfer. All rights reserved.
//

import Foundation
import PromiseKit

protocol LoginInteractorProtocol {
    func loginWith(username: String, password: String)
    func getInitialValues() -> (username: String, password: String)
}

class LoginInteractor: LoginInteractorProtocol {

    let dataManager: LoginDataManagerProtocol
    var presenter: LoginPresenterProtocol?

    init(dataManager: LoginDataManagerProtocol) {
        self.dataManager = dataManager
    }

    func loginWith(username: String, password: String) {
        self.dataManager.loginWith(username: username, password: password).then {
            self.presenter?.loginSuccess()
        }.catch { _ in
            self.presenter?.loginFailBadCredentials()
        }
    }

    func getInitialValues() -> (username: String, password: String) {
        return ("", "")
    }
}
