//
//  CreateAccountAssmbly.swift
//  ViperExample
//
//  Created by Константин Богданов on 19.09.2021.
//
 
import UIKit

class CreateAccountAssembly {
	static func assembleCreateAccountModule() -> UIViewController {
        let view = CreateAccountView()
		let interactor = CreateAccountInteractor()
		let router = CreateAccountRouter()
		let presenter = CreateAccountPresenter(view: view,
											   interactor: interactor,
											   router: router)

		interactor.output = presenter
		view.output = presenter

		router.rootViewController = view
		return view
	}
}
