//
//  CreateAccountAssmbly.swift
//  ViperExample
//
//  Created by Константин Богданов on 19.09.2021.
//
 
import UIKit

class CreateAccountAssembly {
	static func assemble() -> UIViewController & CreateAccountPresenterInput {
		let interactor = CreateAccountInteractor()
		let presenter = CreateAccountPresenter(viewAssembly: {
			return CreateAccountView()
		},
											   interactor: interactor)

		interactor.output = presenter
		return presenter
	}
}
