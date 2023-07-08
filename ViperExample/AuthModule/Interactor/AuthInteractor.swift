//
//  AuthInteractor.swift
//  ViperExample
//
//  Created by Константин Богданов on 26.09.2021.
//

import UIKit

protocol AuthInteractorOutput: AnyObject {
	func loggedIn()
	func loginFailed()
}

protocol AuthInteractorInput {
	var output: AuthInteractorOutput? { get set }

	func login(withLogin login: String, password: String)
}

final class AuthInteractor: AuthInteractorInput {
	weak var output: AuthInteractorOutput?

	func login(withLogin login: String, password: String) {
		if (arc4random() % 100) < 50 {
			output?.loggedIn()
		} else {
			output?.loginFailed()
		}
	}
}
