//  BaseMVP.swift
//  Architecture MVP
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation
import UIKit
import MBProgressHUD

// MARK: - BaseNavigationController
class BaseNavigationController: UINavigationController {

    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - BaseViewController
class BaseViewController <P>: UIViewController {

    var presenter: P?

    // MARK: Loader
    func showLoading(view: UIView, animated: Bool) {
        MBProgressHUD.showAdded(to: view, animated: animated)
    }
    func hideLoading(view: UIView, animated: Bool) {
        MBProgressHUD.hide(for: view, animated: animated)
    }
}

// MARK: - BasePresenter
class BasePresenter <V, R> {

    internal var viewController: V?
    internal var router: R?

    convenience init (viewController: V, router: R? = nil) {
        self.init()
        self.viewController = viewController
        self.router = router
    }

}

// MARK: - BaseRouter
class BaseRouter <P> {

    internal var presenter: P?
    internal var viewController: UIViewController?

    convenience init(presenter: P? = nil, view: UIViewController? = nil) {
        self.init()
        self.presenter = presenter
        self.viewController = view
    }

    internal func show(_ viewCon: UIViewController) {
        if let navigationController = viewController?.navigationController {
            DispatchQueue.main.async {
                navigationController.pushViewController(viewCon, animated: true)
            }
        }
    }

    internal func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        if let navigationController = viewController?.navigationController {
            navigationController.present(viewControllerToPresent, animated: flag, completion: completion)
            return
        }
        viewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
