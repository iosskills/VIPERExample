//
//  CreateAccountPresenter.swift
//  ViperExample
//
//  Created by Константин Богданов on 19.09.2021.
//

import UIKit

protocol CreateAccountPresenterInput {
	var output: CreateAccountPresenterOutput? { get set }
}

protocol CreateAccountPresenterOutput: AnyObject {
	func openAuthScreen(withLogin login: String)
}

final class CreateAccountPresenter: UIViewController, CreateAccountPresenterInput {
	weak var output: CreateAccountPresenterOutput?

	private let interactor: CreateAccountInteractorInput
	private let viewAssembly: () -> UIView & CreateAccountViewInput
	private lazy var accountView = viewAssembly()

	init(viewAssembly: @escaping () -> UIView & CreateAccountViewInput,
		 interactor: CreateAccountInteractorInput) {
		self.viewAssembly = viewAssembly
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	override func loadView() {
		view = accountView
		accountView.output = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
		output?.openAuthScreen(withLogin: login)
	}
}
