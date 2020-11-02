//
//  APIService.swift
//  flickerApiApp
//
//  Created by Desmarais, Jax on 9/25/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import Foundation
import UIKit

class APIService: NSObject {
    let baseURL = "https://api.flickr.com/services/rest"

    func apiToFetchFlickerData(text: String?, completion : @escaping (FlickrImageResult) -> ()) {
        guard let text = text else { return  () }
        var method: URLQueryItem
        
        var components = URLComponents(string: baseURL)
        let apiKey = URLQueryItem(name: "api_key", value: "4ad24d47ae341d8cb6004b93e6a92ad2")
        let format = URLQueryItem(name: "format", value: "json")
        let callback = URLQueryItem(name: "nojsoncallback", value: "1")
        let safeSearch = URLQueryItem(name: "safe_search", value: "1")
        if text.count > 1 {
            method = URLQueryItem(name: "method", value: "flickr.photos.search")
            let searchTerms = URLQueryItem(name: "text", value: text)
            components?.queryItems = [method, apiKey, format, callback, safeSearch, searchTerms]
        } else {
            method = URLQueryItem(name: "method", value: "flickr.photos.search")
            let userId = URLQueryItem(name: "is_commons", value: "true")
            components?.queryItems = [method, apiKey, format, callback, userId]
        }


        let encodedComponents = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "&")
        components?.percentEncodedQuery = encodedComponents
        
        guard let url = components?.url else { return () }
        let request = URLRequest(url: url)
        print(request)

        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data {
                do {
                	let jsonDecoder = JSONDecoder()
                	let photoData = try jsonDecoder.decode(FlickrImageResult.self, from: data)
                    completion(photoData)
                } catch {
                    print("No data recieved")
                }
            }
        }.resume()
    }
    
    func apiToFetchPhotoData(url: URL, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                DispatchQueue.main.async {
					completion(UIImage(data: data))
                }
            }
        }.resume()
    }
}
