//
//  AlertsAsembly.swift
//  ViperExample
//
//  Created by Константин Богданов on 08.07.2023.
//

import UIKit

final class AlertsAsembly {

	static func assemble(title: String,
						 subtitle: String,
						 action: @escaping () -> Void) -> UIViewController {
		let action = UIAlertAction(title: "ОК", style: .default, handler: { _ in
			action()
		})
		let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
		alert.addAction(action)
		return alert
	}
}
