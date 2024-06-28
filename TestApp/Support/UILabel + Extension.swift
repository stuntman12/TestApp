//
//  UILabel + Extension.swift
//  TestApp
//
//  Created by Даниил Иванов on 28.06.2024.
//

import UIKit

extension UILabel {
	func applySettingForNameInCell() {
		self.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		
	}
	
	func applySettingForStatusInCell() {
		self.font = UIFont.systemFont(ofSize: 14, weight: .regular)
	}
	
	func applySettingDetails(text: String) {
		self.text = text
		self.font = UIFont.systemFont(ofSize: 26, weight: .black)
	}
}
