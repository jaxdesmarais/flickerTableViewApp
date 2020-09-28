//
//  APIService.swift
//  flickerApiApp
//
//  Created by Desmarais, Jax on 9/25/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import Foundation

class APIService: NSObject {
    let baseURL = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=4ad24d47ae341d8cb6004b93e6a92ad2&format=json&nojsoncallback=1"

    func apiToFetchFlickerData(completion : @escaping (FlickrImageResult) -> ()) {
        guard let url = URL(string: baseURL) else { return () }

        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
//                print(String(bytes:data, encoding: .utf8))
                let photoData = try! jsonDecoder.decode(FlickrImageResult.self, from: data)
                completion(photoData)
            }
        }.resume()
    }
}
