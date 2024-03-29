//
//  AuthPresenter.swift
//  ViperExample
//
//  Created by Константин Богданов on 26.09.2021.
//

import UIKit

protocol AuthPresenterInput {
	var output: AuthPresenterOutput? { get set }

	func setLogin(_ login: Login)
}

protocol AuthPresenterOutput: AnyObject {
	func authComplete()
	func userEnterIncorrectData()
	func userMovedBack()
}

final class AuthPresenter: UIViewController, AuthPresenterInput {
	weak var output: AuthPresenterOutput?

	private let interactor: AuthInteractorInput
	private let createAuthViewClosure: () -> UIView & AuthViewInput
	private lazy var authView: UIView & AuthViewInput = createAuthViewClosure()

	init(interactor: AuthInteractorInput,
		 createAuthViewClosure: @escaping () -> UIView & AuthViewInput) {
		self.interactor = interactor
		self.createAuthViewClosure = createAuthViewClosure
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		authView.output = self
		view = authView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	func setLogin(_ login: Login) {
		authView.setLoging(login.value)
	}
}

extension AuthPresenter: AuthViewOutput {
	func userPressedEnter(login: String, password: String) {
		authView.showLoader()
		interactor.login(withAccount: Account(login: login, password: password))
	}

	func userMovedBack() {
		output?.userMovedBack()
	}
}

extension AuthPresenter: AuthInteractorOutput {
	func loggedIn() {
		authView.hideLoader()
		output?.authComplete()
	}

	func loginFailed() {
		authView.hideLoader()
		output?.userEnterIncorrectData()
	}
}
