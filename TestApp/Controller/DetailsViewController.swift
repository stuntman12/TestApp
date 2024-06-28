//
//  DetailsViewController.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit

final class DetailsViewController: UIViewController {
	
	private let imageView = UIImageView()
	private let stackView = UIStackView()
	private let labelStatus = UILabel()
	private let labelGender = UILabel()
	private let labelType = UILabel()
	private let labelSpecies = UILabel()
	
	private let network: INetworkManager
	private let indexCharacter: Int
	
	init(network: INetworkManager, index: Int) {
		self.network = network
		self.indexCharacter = index
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setting()
	}
}

private extension DetailsViewController {
	func setting() {
		view.backgroundColor = .white
		settingImageView()
		settingLabel()
		settingStackView()
		fetchStart()
	}
	
	func settingImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imageView)
		imageView.image = UIImage(systemName: "person")
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
			imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
		])
	}
	
	func settingLabel() {
		labelStatus.translatesAutoresizingMaskIntoConstraints = false
		labelGender.translatesAutoresizingMaskIntoConstraints = false
		labelType.translatesAutoresizingMaskIntoConstraints = false
		labelSpecies.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func settingStackView() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)
		stackView.addArrangedSubview(labelStatus)
		stackView.addArrangedSubview(labelGender)
		stackView.addArrangedSubview(labelType)
		stackView.addArrangedSubview(labelSpecies)
		
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.alignment = .center
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
			stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	func showAlert(message: String) {
		let alert = UIAlertController(
			title: "Ошибка",
			message: message,
			preferredStyle: .alert
		)
		
		let actionAlert = UIAlertAction(
			title: "Понял",
			style: .cancel
		)
		
		alert.addAction(actionAlert)
		
		present(alert, animated: true)
	}
	
	func fetchStart() {
		network.fetchIdCharacter(id: indexCharacter) { [weak self] result in
			switch result {
			case .success(let character):
				DispatchQueue.main.async {
					self?.labelStatus.applySettingDetails(text: character.status)
					self?.labelType.applySettingDetails(text: character.type)
					self?.labelGender.applySettingDetails(text: character.gender)
					self?.labelSpecies.applySettingDetails(text: character.species)
					self?.imageView.fetchPhoto(url: character.image)
				}
			case .failure(let error):
				dump(error)
			}
		}
	}
}
