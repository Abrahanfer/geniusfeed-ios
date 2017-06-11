//
//  Router.swift
//  GeniusFeed
//
//  Created by Abrahán Fernández Nieto on 17/4/17.
//  Copyright © 2017 Abrahanfer. All rights reserved.
//

import UIKit

protocol LoginWireframeProtocol {
    func loginView() -> UIViewController
    func showUpLoginView(currentView: UIViewController)
}

class LoginWireframe: LoginWireframeProtocol {

    weak var oldView: UIViewController?

    func loginView() -> UIViewController {
        // load fron storyboard
        let loginView = LoginView()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(dataManager: DataManager.sharedInstance)

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
        oldView = currentView
        let loginView = self.loginView()
        currentView.present(loginView, animated: true) {}
    }
}
