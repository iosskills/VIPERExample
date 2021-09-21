//
//  CreateAccountPresenter.swift
//  ViperExample
//
//  Created by Константин Богданов on 19.09.2021.
//

import Foundation

protocol CreateAccountPresenterInput {
	var output: CreateAccountPresenterOutput? { get set }
}

protocol CreateAccountPresenterOutput: AnyObject {

}

final class CreateAccountPresenter {
	weak var output: CreateAccountPresenterOutput?

	private let interactor: CreateAccountInteractorInput
	private let router: CreateAccountRouterInput
	private let view: CreateAccountViewInput

	init(view: CreateAccountViewInput,
		 interactor: CreateAccountInteractorInput,
		 router: CreateAccountRouterInput) {
		self.view = view
		self.interactor = interactor
		self.router = router
	}
}

extension CreateAccountPresenter: CreateAccountViewOutput {
	func userSelecCreateAccount(withLogin login: String, password: String) {
		interactor.createAccount(withLogin: login, password: password)
	}
}

extension CreateAccountPresenter: CreateAccountInteractorOutput {
	func didReceive(error: String) {

	}

	func didCreateAccount(withLogin login: String) {
		router.openAuthScreen(withLogin: login)
	}
}
