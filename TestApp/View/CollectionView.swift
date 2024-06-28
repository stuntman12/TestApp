//
//  CollectionView.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit

final class CollectionView: UIView {
	private var collectiomView: UICollectionView!
	
	
	var characters: [Descr] = [] {
		didSet {
			self.collectiomView.reloadData()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		collectiomView = UICollectionView(frame: .zero, collectionViewLayout: settingFlowLayout())
		settingCollection()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addDelegate(_ any: UICollectionViewDelegate) {
		collectiomView.delegate = any
	}
}

extension CollectionView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		characters.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "\(CharacterCell.self)",
			for: indexPath
		) as? CharacterCell else { return UICollectionViewCell() }
		let item = characters[indexPath.item]
		cell.configureImage(url: item.image)
		
		cell.configure(item)
		return cell
	}
}

private extension CollectionView {
	func settingCollection() {
		addSubview(collectiomView)
		collectiomView.translatesAutoresizingMaskIntoConstraints = false
		collectiomView.dataSource = self
		collectiomView.register(
			CharacterCell.self,
			forCellWithReuseIdentifier: "\(CharacterCell.self)"
		)
		
		NSLayoutConstraint.activate([
			collectiomView.heightAnchor.constraint(equalTo: self.heightAnchor),
			collectiomView.widthAnchor.constraint(equalTo: self.widthAnchor)
		])
	}
	
	func settingFetchPage() {
		
	}
	
	func settingFlowLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			index,
			envirment in
			let item = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(
					widthDimension: .fractionalWidth(0.5),
					heightDimension: .fractionalHeight(1)
				)
			)
			
			item.contentInsets = NSDirectionalEdgeInsets(
				top: 0,
				leading: 8,
				bottom: 0,
				trailing: 8
			)
			
			let group = NSCollectionLayoutGroup.horizontal(
				layoutSize: NSCollectionLayoutSize(
					widthDimension: .fractionalWidth(1),
					heightDimension: .fractionalHeight(0.35)
				),
				repeatingSubitem: item,
				count: 2
			)
			
			let section = NSCollectionLayoutSection(group: group)
			
			section.interGroupSpacing = 8
			
			return section
		}
		return layout
	}
}
