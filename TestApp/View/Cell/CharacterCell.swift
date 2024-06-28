//
//  CharacterCell.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
	
	private let imageView = UIImageView()
	private let labelStackView = UIStackView()
	private let name = UILabel()
	private let status = UILabel()
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		setting()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(_ item: Descr) {
		name.text = item.name
		status.text = item.status.rawValue
	}
	
	func configureImage(url: String) {
		imageView.fetchPhoto(url: url)
	}
}

private extension CharacterCell {
	func setting() {
		contentView.backgroundColor = .white
		settingImage()
		settingLabel()
		settingStack()
	}
	
	func settingImage() {
		imageView.contentMode = .scaleAspectFill
		contentView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8)
		])
	}
	
	func settingLabel() {
		name.translatesAutoresizingMaskIntoConstraints = false
		name.applySettingForNameInCell()
		
		status.translatesAutoresizingMaskIntoConstraints = false
		status.applySettingForStatusInCell()
	}
	
	func settingStack() {
		labelStackView.addArrangedSubview(name)
		labelStackView.addArrangedSubview(status)
		labelStackView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(labelStackView)
		labelStackView.axis = .vertical
		
		NSLayoutConstraint.activate([
			labelStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
			labelStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
