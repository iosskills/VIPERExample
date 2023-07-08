//
//  AuthCoordinator.swift
//  ViperExample
//
//  Created by Константин Богданов on 26.09.2021.
//

import UIKit

enum LoginFlowResult {
	case loggedIn
	case failed
}

class AuthCoordinator: Coordinator<Login, LoginFlowResult> {

	private weak var initialController: UIViewController?
	private var module: (AuthPresenterInput & UIViewController)?
	private let authModuleAssembly: () -> AuthPresenterInput & UIViewController
	init(initialController: UIViewController,
		 authModuleAssembly: @escaping () -> AuthPresenterInput & UIViewController) {
		self.initialController = initialController
		self.authModuleAssembly = authModuleAssembly
		super.init()
	}

	override func start(parameter: Login) {
		var presenter = authModuleAssembly()
		presenter.output = self
		presenter.setLogin(parameter)
		module = presenter
		initialController?.present(presenter, animated: true, completion: nil)
	}
}

extension AuthCoordinator: AuthPresenterOutput {
	func authComplete() {
		module?.dismiss(animated: true, completion: { [weak self] in
			self?.finishFlow?(.failed)
		})
	}

	func userEnterIncorrectData() {

	}
}
