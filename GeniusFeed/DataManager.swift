//
//  DataManager.swift
//  GeniusFeed
//
//  Created by Abrahán Fernández Nieto on 19/4/17.
//  Copyright © 2017 Abrahanfer. All rights reserved.
//

import Foundation
import PromiseKit

protocol LoginDataManagerProtocol {
    func loginWith(username: String, password: String) -> Promise<Void>
}

enum LoginError: Error {
    case loginFail, badCredentials
}

class DataManager: LoginDataManagerProtocol {

    static let sharedInstance = DataManager()

    func loginWith(username: String, password: String) -> Promise<Void> {
        return Promise { fulfill, reject in
            if arc4random_uniform(1000) < 500 {
                fulfill()
            } else {
                reject(LoginError.loginFail)
            }
        }
    }
}
