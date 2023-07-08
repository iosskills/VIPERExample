//
//  AuthView.swift
//  ViperExample
//
//  Created by Константин Богданов on 26.09.2021.
//

import UIKit

protocol AuthViewOutput: AnyObject {
	func userMovedBack()
}

protocol AuthViewInput {
	var output: AuthViewOutput? { get set }
	func setLoging(_ login: String)
}

final class AuthView: UIView, AuthViewInput {
	weak var output: AuthViewOutput?

	private let loginLabel: UILabel
	private let backButton: UIButton

	init() {
		loginLabel = UILabel()
		backButton = UIButton()
		super.init(frame: .zero)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setLoging(_ login: String) {
		loginLabel.text = login
	}

	private func setupViews() {
		backgroundColor = .white
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		backButton.translatesAutoresizingMaskIntoConstraints = false

		addSubview(loginLabel)
		addSubview(backButton)

		NSLayoutConstraint.activate([
										loginLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
										loginLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
										backButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
										backButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
										backButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
										backButton.heightAnchor.constraint(equalToConstant:  40)])

		loginLabel.textColor = .black
		backButton.setTitle("Назад", for: .normal)

		backButton.backgroundColor = .gray

		backButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
	}

	@objc private func buttonPressed() {
		output?.userMovedBack()
	}
}
