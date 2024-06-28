//
//  TabBarPage.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit

enum TabBarPage: CaseIterable {
	case characters
	case locations
	case episodes
	case settings
	
	var title: String {
		switch self {
		case .characters:
			return "Characters"
		case .locations:
			return "Locations"
		case .episodes:
			return "Episodes"
		case .settings:
			return "Settings"
		}
	}
	
	var icon: UIImage {
		switch self {
		case .characters:
			return UIImage(systemName: "person")!
		case .locations:
			return UIImage(systemName: "globe")!
		case .episodes:
			return UIImage(systemName: "tv")!
		case .settings:
			return UIImage(systemName: "gear")!
		}
	}
	
	var controller: UIViewController {
		switch self {
		case .characters:
			return CharactersViewController(network: NetworkManager())
		case .locations:
			return LocationsViewController()
		case .episodes:
			return EpisodesViewController()
		case .settings:
			return SettingsViewController()
		}
	}
}
