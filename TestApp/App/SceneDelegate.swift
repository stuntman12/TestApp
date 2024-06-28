//
//  SceneDelegate.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit
import FirebaseCore
import FirebaseRemoteConfig

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		FirebaseApp.configure()
		
		
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let remoteConfig = RemoteConfig.remoteConfig()
		let settings = RemoteConfigSettings()
		settings.minimumFetchInterval = 60
		remoteConfig.configSettings = settings
		
		// проверка FireBase RemoteConfig
		try? remoteConfig.setDefaults(from: ["needForceUpdate": false])
		
		remoteConfig.fetchAndActivate { [weak self] (status, error) in
			if status != .error {
				let boolValue = remoteConfig.configValue(forKey: "needForceUpdate").boolValue
				dump(boolValue)
				switch boolValue {
				case true:
					let viewController = OtherViewController()
					self?.window?.rootViewController = viewController
				case false:
					self?.window?.rootViewController = TabBarController()
				}
			}
		}
		
		window = UIWindow(windowScene: windowScene)
		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {}

	func sceneDidBecomeActive(_ scene: UIScene) {}

	func sceneWillResignActive(_ scene: UIScene) {}

	func sceneWillEnterForeground(_ scene: UIScene) {}

	func sceneDidEnterBackground(_ scene: UIScene) {}
}

