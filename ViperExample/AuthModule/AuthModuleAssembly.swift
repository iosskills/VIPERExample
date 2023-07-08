//
//  AuthModuleAssembly.swift
//  ViperExample
//
//  Created by Константин Богданов on 08.07.2023.
//

import UIKit

final class AuthModuleAssembly {
	static func assemble() -> UIViewController & AuthPresenterInput {
		let interactor = AuthInteractor()
		let presenter = AuthPresenter(interactor: interactor) {
			return AuthView()
		}

		interactor.output = presenter
		return presenter
	}
}
