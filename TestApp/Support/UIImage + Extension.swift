//
//  UIImage + Extension.swift
//  TestApp
//
//  Created by Даниил Иванов on 28.06.2024.
//

import UIKit

extension UIImageView {
	func fetchPhoto(url: String) {
		let cache = URLCache()
		guard let url = URL(string: url) else { return }
		
		let request = URLRequest(url: url)

		
		let session = URLSession.shared
		
		if let cache = cache.cachedResponse(for: request) {
			self.image = UIImage(data: cache.data)
		} else {
			let dataTask = session.dataTask(with: request) { data, response, error in
				guard let data else { return }
				guard let response else { return }
				
				let cacheResponse = CachedURLResponse(response: response, data: data)
				cache.storeCachedResponse(cacheResponse, for: request)
				DispatchQueue.main.async {
					self.image = UIImage(data: data)
				}
			}
			dataTask.resume()
		}
	}
}
