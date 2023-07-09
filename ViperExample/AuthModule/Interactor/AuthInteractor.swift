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

	func login(withAccount account: Account)
}

final class AuthInteractor: AuthInteractorInput {
	weak var output: AuthInteractorOutput?

	func login(withAccount account: Account) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
			if (arc4random() % 100) < 50 {
				self?.output?.loggedIn()
			} else {
				self?.output?.loginFailed()
			}
		}
	}
}
