//
//  CreateAccountRouter.swift
//  ViperExample
//
//  Created by Константин Богданов on 19.09.2021.
//

import UIKit

final class CreateAccountCoordinator: Coordinator<Void, Void> {
	private weak var window: UIWindow?
	private var module: (UIViewController & CreateAccountPresenterInput)?
	private let moduleAssembly: () -> UIViewController & CreateAccountPresenterInput
	private let authCoordinatorAssembly: (_ root: UIViewController) -> Coordinator<Login, LoginFlowResult>
	private var authCoordinator: Coordinator<Login, LoginFlowResult>?

	init(window: UIWindow,
		 moduleAssembly: @escaping () -> UIViewController & CreateAccountPresenterInput,
		 authCoordinatorAssembly: @escaping (_ root: UIViewController) -> Coordinator<Login, LoginFlowResult>) {
		self.window = window
		self.moduleAssembly = moduleAssembly
		self.authCoordinatorAssembly = authCoordinatorAssembly
	}

	override func start(parameter: Void) {
		var module = moduleAssembly()
		module.output = self
		self.module = module
		window?.rootViewController = module
		window?.makeKeyAndVisible()
	}
}

extension CreateAccountCoordinator: CreateAccountPresenterOutput {
	func openAuthScreen(withLogin login: String) {
		guard let root = module else { return }
		let coordinator = authCoordinatorAssembly(root)
		coordinator.finishFlow = { [weak self] _ in
			self?.authCoordinator = nil
		}
		self.authCoordinator = coordinator
		coordinator.start(parameter: .init(value: login))
	}
}
