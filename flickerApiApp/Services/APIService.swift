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
        // TO DO: fix if nil
        guard let text = text else { return  () }
        
        var components = URLComponents(string: baseURL)
        // TO DO: add each query item from URL ✅
        let method = URLQueryItem(name: "method", value: "flickr.photos.getRecent")
        let searchTerms = URLQueryItem(name: "text", value: text)
        let apiKey = URLQueryItem(name: "api_key", value: "4ad24d47ae341d8cb6004b93e6a92ad2")
        let format = URLQueryItem(name: "format", value: "json")
        let callback = URLQueryItem(name: "nojsoncallback", value: "1")
        components?.queryItems = [method, searchTerms, apiKey, format, callback]

        let encodedComponents = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        components?.percentEncodedQuery = encodedComponents
        
        guard let url = components?.url else { return () }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data {
                do {
                	let jsonDecoder = JSONDecoder()
                    // TO DO: fix force unwrapping try! ✅
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
