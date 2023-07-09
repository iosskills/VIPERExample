//
//  AppAssembly.swift
//  ViperExample
//
//  Created by Константин Богданов on 08.07.2023.
//

import UIKit

final class AppAssembly {

	static func createCoordinatorAndViewController(window: UIWindow) -> Coordinator<Void, Void> {
		return CreateAccountCoordinator(window: window,
										moduleAssembly: CreateAccountAssembly.assemble,
										authCoordinatorAssembly: {  root in
			return AuthCoordinator(initialController: root,
								   authModuleAssembly: AuthModuleAssembly.assemble,
								   alertAssembly: { AlertsAsembly.assemble(title: $0, subtitle: $1, action: $2)} )
		})
	}
}
