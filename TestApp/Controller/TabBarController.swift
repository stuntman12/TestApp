//
//  TabBarController.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit

final class TabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		settingTabBar()
	}
}

extension TabBarController {
	// перебираем страницы и создаем контроллеры
	func settingTabBar() {
		let pages = TabBarPage.allCases
		let controllers: [UINavigationController] = pages.map { page in
			getTabBar(page,page.controller)
		}
		setViewControllers(controllers, animated: true)
		selectedIndex = 0
	}
	
	// добавляем к контролерам иконки таб бара
	func getTabBar(_ page: TabBarPage, _ controller: UIViewController) -> UINavigationController {
		let navigation = UINavigationController(rootViewController: controller)
		
		navigation.tabBarItem = UITabBarItem(
			title: page.title,
			image: page.icon,
			tag: page.hashValue
		)
		
		return navigation
	}
}
