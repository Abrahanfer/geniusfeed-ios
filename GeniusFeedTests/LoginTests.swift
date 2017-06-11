//
//  GeniusFeedTests.swift
//  GeniusFeedTests
//
//  Created by Abrahán Fernández Nieto on 14/4/17.
//  Copyright © 2017 Abrahanfer. All rights reserved.
//

import XCTest
import PromiseKit
@testable import GeniusFeed

class LoginDataManagerMock: LoginDataManagerProtocol {
    func loginWith(username: String, password: String) -> Promise<Void> {
        return Promise { fulfill, reject in
            if username == "loginok" {
                fulfill()
            } else {
                reject(LoginError.loginFail)
            }
        }
    }
}

class LoginPresenterMock: LoginPresenterProtocol {
    var loginTextField = ""
    var passwordTextField = ""

    var interactor: LoginInteractorProtocol?
    var successCompletionClosure: () -> Void = {}
    var failCompletionClosure: () -> Void = {}

    func loginSuccess() {
        successCompletionClosure()
    }

    func loginFailBadCredentials() {
        failCompletionClosure()
    }

    func loginButtonCallback() {
        interactor?.loginWith(username: loginTextField, password: passwordTextField)
    }
}

class LoginWireframeMock: LoginWireframeProtocol {
    func loginView() -> UIViewController {
        // load fron storyboard
        let loginView = LoginView()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(dataManager: LoginDataManagerMock())

        // set view with presenter
        loginView.presenter = presenter

        // set presenter with view, router, interactor
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.wireframe = self

        // set interactor with presenter
        interactor.presenter = presenter

        return loginView
    }

    func showUpLoginView(currentView: UIViewController) {
        print("TODO")
    }
}

class LoginTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in 
        // the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in
        // the class.
        super.tearDown()
    }

    func testLoginOk() {
        let presenter = LoginPresenterMock()
        let interactor = LoginInteractor(dataManager: LoginDataManagerMock())

        presenter.interactor = interactor
        interactor.presenter = presenter

        presenter.loginTextField = "loginok"
        presenter.passwordTextField = ""
        let succcessExpectation = self.expectation(description: "Login success")
        presenter.successCompletionClosure = {
            XCTAssert(true)
            succcessExpectation.fulfill()
        }

        presenter.failCompletionClosure = {
            XCTFail()
        }

        presenter.loginButtonCallback()

        wait(for: [succcessExpectation], timeout: 0.5)
    }

    func testLoginKo() {
        let presenter = LoginPresenterMock()
        let interactor = LoginInteractor(dataManager: LoginDataManagerMock())

        presenter.interactor = interactor
        interactor.presenter = presenter

        presenter.loginTextField = "asdlkajshud"
        presenter.passwordTextField = ""
        let failExpectation = self.expectation(description: "Login fail")
        presenter.successCompletionClosure = {
            XCTFail()
        }

        presenter.failCompletionClosure = {
            XCTAssert(true)
            failExpectation.fulfill()
        }

        presenter.loginButtonCallback()

        wait(for: [failExpectation], timeout: 0.5)
    }
}
