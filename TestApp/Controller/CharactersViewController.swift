//
//  ViewController.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit

class CharactersViewController: UIViewController {
	
	private let collection = CollectionView()
	
	private let network: INetworkManager
	
	init(network: INetworkManager) {
		self.network = network
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setting()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		collection.frame = view.safeAreaLayoutGuide.layoutFrame
	}
}

extension CharactersViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		let item = self.collection.characters[indexPath.item]
		let viewController = DetailsViewController(network: network, index: item.id)
		viewController.title = item.name
		navigationController?.pushViewController(viewController, animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.row == self.collection.characters.count - 1 {
			
		}
	}
}

private extension CharactersViewController {
	func setting() {
		view.backgroundColor = .white
		settingNavBar()
		addView()
		startFetch()
		collection.addDelegate(self)
	}
	
	func settingNavBar() {
		title = "Characters"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.leftBarButtonItem?.title = "Back"
	}
	
	func addView() {
		view.addSubview(collection)
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
	
}

private extension CharactersViewController {

	func startFetch() {
		network.fetchCharacters {  [weak self] result in
			switch result {
			case .success(let characters):
				DispatchQueue.main.async {
					self?.collection.characters = characters
				}
			case .failure(let error):
				DispatchQueue.main.async {
					self?.showAlert(message: error.localizedDescription)
				}
			}
		}
	}
}

