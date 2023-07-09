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
	case movedBack
}

class AuthCoordinator: Coordinator<Login, LoginFlowResult> {

	private weak var initialController: UIViewController?
	private var module: (AuthPresenterInput & UIViewController)?
	private let authModuleAssembly: () -> AuthPresenterInput & UIViewController
	private let alertAssembly: (String, String, @escaping () -> Void) -> UIViewController

	init(initialController: UIViewController,
		 authModuleAssembly: @escaping () -> AuthPresenterInput & UIViewController,
		 alertAssembly: @escaping (_ title: String,
								   _ subtitle: String,
								   _ action: @escaping () -> Void) -> UIViewController) {
		self.initialController = initialController
		self.authModuleAssembly = authModuleAssembly
		self.alertAssembly = alertAssembly
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
	func userMovedBack() {
		module?.dismiss(animated: true, completion: { [weak self] in
			self?.finishFlow?(.movedBack)
		})
	}

	func authComplete() {
		module?.dismiss(animated: true, completion: { [weak self] in
			self?.finishFlow?(.loggedIn)
		})
	}

	func userEnterIncorrectData() {
		let alert = alertAssembly("Ошибка", "Вы ввели некорректные данные!", { [weak self] in
			self?.module?.presentedViewController?.dismiss(animated: true)
		})
		module?.present(alert, animated: true)
	}
}
