//
//  Coordinator.swift
//  ViperExample
//
//  Created by Константин Богданов on 26.09.2021.
//

import UIKit

class Coordinator<Input, Result> {

	var finishFlow: ((Result) -> Void)?

	func start(parameter: Input) {
		assert(false, "Must be overridden by subclass")
	}
}

extension Coordinator where Input == Void {
	func start() {
		start(parameter: ())
	}
}
