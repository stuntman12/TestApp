//
//  CharacterModel.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import Foundation

// MARK: - Character
struct Character: Codable {
	let info: Info
	let results: [Descr]
}

// MARK: - Info
struct Info: Codable {
	let count, pages: Int
	let next: String
}

// MARK: - Result
struct Descr: Codable {
	let id: Int
	let name: String
	let status: Status
	let species: Species
	let type: String
	let gender: Gender
	let image: String
	let url: String
}

enum Gender: String, Codable {
	case female = "Female"
	case male = "Male"
	case unknown = "unknown"
}

enum Species: String, Codable {
	case alien = "Alien"
	case human = "Human"
}

enum Status: String, Codable {
	case alive = "Alive"
	case dead = "Dead"
	case unknown = "unknown"
}
