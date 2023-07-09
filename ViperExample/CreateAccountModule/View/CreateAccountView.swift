//
//  CreateAccountView.swift
//  ViperExample
//
//  Created by Константин Богданов on 19.09.2021.
//

import UIKit

protocol CreateAccountViewInput {
	var output: CreateAccountViewOutput? { get set }
	func showLoader()
	func hideLoader()
}

protocol CreateAccountViewOutput {
	func userSelecCreateAccount(withLogin login: String, password: String)
}

final class CreateAccountView: UIView, CreateAccountViewInput {
	var output: CreateAccountViewOutput?

	private let titleLabel: UILabel
	private let loginField: UITextField
	private let passwordField: UITextField
	private let acceptButton: UIButton
	private let loader: UIActivityIndicatorView

	init() {
		titleLabel = UILabel()
		loginField = UITextField()
		passwordField = UITextField()
		acceptButton = UIButton()
		loader = UIActivityIndicatorView(frame: .zero)
		super.init(frame: .zero)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
		loginField.translatesAutoresizingMaskIntoConstraints = false
		passwordField.translatesAutoresizingMaskIntoConstraints = false
		acceptButton.translatesAutoresizingMaskIntoConstraints = false
		loader.translatesAutoresizingMaskIntoConstraints = false

		addSubview(titleLabel)
		addSubview(loginField)
		addSubview(passwordField)
		addSubview(acceptButton)
		addSubview(loader)

		NSLayoutConstraint.activate([
			titleLabel.bottomAnchor.constraint(equalTo: loginField.topAnchor, constant: -8),
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			loginField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
			loginField.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -16),
			loginField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			loginField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

			passwordField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
			passwordField.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
			acceptButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
			passwordField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			passwordField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			acceptButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
			acceptButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
			acceptButton.heightAnchor.constraint(equalToConstant:  40),
			loader.topAnchor.constraint(equalTo: topAnchor),
			loader.bottomAnchor.constraint(equalTo: bottomAnchor),
			loader.trailingAnchor.constraint(equalTo: trailingAnchor),
			loader.leadingAnchor.constraint(equalTo: leadingAnchor)
		])
		titleLabel.textAlignment = .center
		titleLabel.textColor = .black
		loginField.placeholder = "Введите логин"
		loginField.textColor = .black
		passwordField.placeholder = "Введите пароль"
		passwordField.textColor = .black

		acceptButton.setTitle("Создать аккаунт", for: .normal)
		acceptButton.backgroundColor = .gray
		acceptButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

		loader.isHidden = true
	}

	@objc private func buttonPressed() {
		output?.userSelecCreateAccount(withLogin: loginField.text ?? "",
									  password: passwordField.text ?? "")
	}
}
