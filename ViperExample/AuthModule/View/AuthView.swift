//
//  AuthView.swift
//  ViperExample
//
//  Created by Константин Богданов on 26.09.2021.
//

import UIKit

protocol AuthViewOutput: AnyObject {
	func userMovedBack()
	func userPressedEnter(login: String, password: String)
}

protocol AuthViewInput {
	var output: AuthViewOutput? { get set }
	func setLoging(_ login: String)
	func showLoader()
	func hideLoader()
}

final class AuthView: UIView, AuthViewInput {
	weak var output: AuthViewOutput?

	private let titleLabel: UILabel
	private let loginLabel: UILabel
	private let passworkField: UITextField
	private let enterButton: UIButton
	private let backButton: UIButton
	private let loader: UIActivityIndicatorView

	init() {
		titleLabel = UILabel()
		loginLabel = UILabel()
		passworkField = UITextField()
		enterButton = UIButton()
		backButton = UIButton()
		loader = UIActivityIndicatorView()
		super.init(frame: .zero)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setLoging(_ login: String) {
		loginLabel.text = login
	}
	func showLoader() {
		loader.isHidden = false
		loader.startAnimating()
	}

	func hideLoader() {
		loader.isHidden = true
		loader.stopAnimating()
	}

	private func setupViews() {
		backgroundColor = .white
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		passworkField.translatesAutoresizingMaskIntoConstraints = false
		backButton.translatesAutoresizingMaskIntoConstraints = false
		enterButton.translatesAutoresizingMaskIntoConstraints = false
		loader.translatesAutoresizingMaskIntoConstraints = false

		addSubview(titleLabel)
		addSubview(loginLabel)
		addSubview(passworkField)
		addSubview(enterButton)
		addSubview(backButton)
		addSubview(loader)
		loginLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
		NSLayoutConstraint.activate([
			titleLabel.bottomAnchor.constraint(equalTo: loginLabel.topAnchor, constant: -8),
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			loginLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			loginLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
			loginLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor),
			passworkField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
			passworkField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
			passworkField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
			enterButton.topAnchor.constraint(equalTo: passworkField.bottomAnchor, constant: 16),
			enterButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
			enterButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
			enterButton.heightAnchor.constraint(equalToConstant:  40),
			backButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 16),
			backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
			backButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
			backButton.heightAnchor.constraint(equalToConstant:  40),
			loader.topAnchor.constraint(equalTo: topAnchor),
			loader.bottomAnchor.constraint(equalTo: bottomAnchor),
			loader.trailingAnchor.constraint(equalTo: trailingAnchor),
			loader.leadingAnchor.constraint(equalTo: leadingAnchor)])

		titleLabel.text = "Введите данные"
		titleLabel.textAlignment = .center
		passworkField.placeholder = "Пароль"
		loginLabel.textColor = .black
		enterButton.setTitle("Войти", for: .normal)
		enterButton.backgroundColor = .gray
		enterButton.addTarget(self,
							  action: #selector(enterButtonPressed),
							  for: .touchUpInside)
		loader.isHidden = true
		backButton.setTitle("Назад", for: .normal)
		backButton.backgroundColor = .gray
		backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
		enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
	}

	@objc private func enterButtonPressed() {
		guard let login = loginLabel.text, let password = passworkField.text else {
			return
		}
		output?.userPressedEnter(login: login, password: password)
	}

	@objc private func backButtonPressed() {
		output?.userMovedBack()
	}
}
