//
//  APIService.swift
//  flickerApiApp
//
//  Created by Desmarais, Jax on 9/25/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import Foundation

class APIService {
    func apiToFetchFlickerData() {
        let baseURL = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=4ad24d47ae341d8cb6004b93e6a92ad2&format=json&nojsoncallback=1"

        let url = URL(string: baseURL)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    print(String(bytes:data, encoding: .utf8)!)
                }
            }
        }
        task.resume()
    }
}
