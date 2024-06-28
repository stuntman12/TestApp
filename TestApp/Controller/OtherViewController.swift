//
//  OtherViewController.swift
//  TestApp
//
//  Created by Даниил Иванов on 28.06.2024.
//

import UIKit

final class OtherViewController: UIViewController {
	private let updateButton = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setting()
	}
}

private extension OtherViewController {
	func setting() {
		view.backgroundColor = .white
		settingButton()
	}
	
	func settingButton() {
		view.addSubview(updateButton)
		updateButton.translatesAutoresizingMaskIntoConstraints = false
		
		updateButton.setTitle(
			"UPDATE NOW",
			for: .normal
		)
		
		updateButton.backgroundColor = .systemBlue
		
		NSLayoutConstraint.activate([
			updateButton.heightAnchor.constraint(equalToConstant: 44),
			updateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
}
