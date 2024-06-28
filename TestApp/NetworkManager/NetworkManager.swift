//
//  NetworkManager.swift
//  TestApp
//
//  Created by Даниил Иванов on 27.06.2024.
//

import UIKit

typealias CharacterData = (Result<[Descr], Error>) -> Void
typealias CharacterId = (Result<CharacterID, Error>) -> Void
typealias PhotoForUrl = (Result<Data, Error>) -> Void

protocol INetworkManager: AnyObject {
	func fetchCharacters(handler: @escaping(CharacterData))
	func fetchIdCharacter(id: Int, handler: @escaping(CharacterId))
	func fetchPhoto(url: String, handler: @escaping(PhotoForUrl))
}

final class NetworkManager: INetworkManager {
	
	private let session = URLSession.shared
	private let cache = URLCache()
	
	// Загрузка фото
	func fetchPhoto(url: String, handler: @escaping (PhotoForUrl)) {
		guard let url = URL(string: url) else {
			return handler(.failure(ErrorNetwork.urlError))
		}
		
		let request = URLRequest(url: url)
		
		if let cache = cache.cachedResponse(for: request) {
			handler(.success(cache.data))
		} else {
			let dataTask = session.dataTask(with: request) { data, response, error in
				guard let data else { return handler(.failure(ErrorNetwork.noData))}
				guard let response else { return }
				let cacheResponse = CachedURLResponse(response: response, data: data)
				self.cache.storeCachedResponse(cacheResponse, for: request)
				
				handler(.success(data))
			}
			dataTask.resume()
		}
	}
	
	
	// Загрузка по ID
	func fetchIdCharacter(id: Int, handler: @escaping (CharacterId)) {
		let urlWidthId = URLlink.characters.rawValue + "/" + id.description
		guard let url = URL(string: urlWidthId) else {
			return handler(.failure(ErrorNetwork.urlError))
		}
		let request = URLRequest(url: url)
		
		if let cache = cache.cachedResponse(for: request) {
			do {
				let model = try JSONDecoder().decode(CharacterID.self, from: cache.data)
				handler(.success(model))
			} catch {
				handler(.failure(ErrorNetwork.failDecode))
			}
		} else {
			let dataTask = session.dataTask(with: request) { data, response, error in
				
				guard let data else { return handler(.failure(ErrorNetwork.noData))}
				
				guard let response else { return }
				
				let cacheResponse = CachedURLResponse(response: response, data: data)
				self.cache.storeCachedResponse(cacheResponse, for: request)
				
				do {
					let model = try JSONDecoder().decode(CharacterID.self, from: data)
					handler(.success(model))
				} catch {
					handler(.failure(ErrorNetwork.failDecode))
				}
			}
			dataTask.resume()
		}
		
	}
	
	// Загрузка для коллекции
	func fetchCharacters(handler: @escaping(CharacterData)) {
		guard let url = URL(string: URLlink.characters.rawValue) else { return
			handler(.failure(ErrorNetwork.urlError))
		}
		let request = URLRequest(url: url)
		
		if let cache = cache.cachedResponse(for: request) {
			do {
				let model = try JSONDecoder().decode(Character.self, from: cache.data)
				handler(.success(model.results))
			} catch {
				handler(.failure(ErrorNetwork.failDecode))
			}
		} else {
			let dataTask = session.dataTask(with: request) { data, response, error in
				
				guard let data else { return handler(.failure(ErrorNetwork.noData))}
				
				guard let response else { return }
				
				let cacheResponse = CachedURLResponse(response: response, data: data)
				self.cache.storeCachedResponse(cacheResponse, for: request)
				
				
				do {
					let model = try JSONDecoder().decode(Character.self, from: data)
					handler(.success(model.results))
				} catch {
					handler(.failure(ErrorNetwork.failDecode))
				}
			}
			dataTask.resume()
		}
	}
}

