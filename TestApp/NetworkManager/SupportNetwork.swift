//
//  SupportNetwork.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import Foundation

enum URLlink: String {
	case characters = "https://rickandmortyapi.com/api/character"
}

enum ErrorNetwork: Error, LocalizedError {
	case urlError
	case noData
	case failDecode
	
	var errorDescription: String {
		switch self {
		case .urlError:
			return "Проблема с URL"
		case .noData:
			return "Нет Data"
		case .failDecode:
			return "Не удалось декодировать"
		}
	}
}

enum Method: String {
	case get = "GET"
}

