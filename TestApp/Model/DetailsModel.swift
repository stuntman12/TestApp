//
//  DetailsModel.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import Foundation

// MARK: - Character
struct CharacterID: Codable {
	let id: Int
	let name, status, species, type: String
	let gender: String
	let origin, location: Location
	let image: String
	let episode: [String]
	let url: String
	let created: String
}

// MARK: - Location
struct Location: Codable {
	let name: String
	let url: String
}
