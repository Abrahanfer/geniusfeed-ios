//
//  LoginPresenter.swift
//  GeniusFeed
//
//  Created by Abrahán Fernández Nieto on 17/4/17.
//  Copyright © 2017 Abrahanfer. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol {
    var loginTextField: String {get set}
    var passwordTextField: String {get set}

    func loginSuccess()
    func loginFailBadCredentials()
    func loginButtonCallback()
}

class LoginPresenter: LoginPresenterProtocol {
    var loginTextField = ""
    var passwordTextField = ""

    var interactor: LoginInteractorProtocol?
    var view: LoginViewProtocol?
    var wireframe: LoginWireframeProtocol?

    private func setInitialValues() {
        if let initialValues = self.interactor?.getInitialValues() {
            loginTextField = initialValues.username
            passwordTextField = initialValues.password
        }
    }

    func loginSuccess() {
        print("login ok")
    }

    func loginFailBadCredentials() {
        print("login ko")
    }

    func loginButtonCallback() {
        self.interactor?.loginWith(username: loginTextField, password: passwordTextField)
    }

}
