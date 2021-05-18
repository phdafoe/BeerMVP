//
//  SearchCoordinator.swift
//  BeerMVP
//
//  Created by Andres Felipe Ocampo Eljaiek on 18/5/21.
//

import Foundation

final class SearchCoordinator {


    static func buildNavigation() -> BaseNavigationController {
        let navigationController = BaseNavigationController(rootViewController: buildViewController())
        return navigationController
    }

    static func buildViewController() -> SearchViewController {
        let viewController = SearchViewController(nibName: SearchViewController.defaultReuseIdentifierViewController, bundle: nil)
        viewController.presenter = buildPresenter(viewController: viewController)
        return viewController
    }

    static fileprivate func buildPresenter(viewController: SearchViewController) -> SearchPresenterProtocolOutput {
        let presenter = SearchPresenter(viewController: viewController)
        presenter.provider = buildProvider()
        presenter.router = buildRouter(viewController: viewController, presenter: presenter)
        return presenter
    }

    static fileprivate func buildRouter(viewController: SearchViewController, presenter: SearchPresenterProtocolOutput) -> SearchRouterProtocolOutput {
        let router = SearchRouter(presenter: presenter, view: viewController)
        return router
    }

    static func buildProvider() -> SearchProviderProtocol {
        let provider = SearchProvider()
        return provider
    }

}
