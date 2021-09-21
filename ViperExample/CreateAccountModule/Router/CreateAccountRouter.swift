//
//  CreateAccountRouter.swift
//  ViperExample
//
//  Created by Константин Богданов on 19.09.2021.
//

import UIKit

protocol CreateAccountRouterInput {
	func openAuthScreen(withLogin: String)
}

final class CreateAccountRouter: CreateAccountRouterInput {
	weak var rootViewController: UIViewController?

	func openAuthScreen(withLogin: String) {
		let vc = UIViewController(nibName: nil, bundle: nil)
		vc.view.backgroundColor = .green
		rootViewController?.present(vc, animated: true, completion: nil)
	}
}
