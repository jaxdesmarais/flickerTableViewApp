//
//  Photo.swift
//  flickerApiApp
//
//  Created by Desmarais, Jax on 9/25/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import UIKit

struct FlickrImageResult: Codable {
    let photos : FlickrPagedImageResult?
}

struct FlickrPagedImageResult: Codable {
    let photo : [FlickrPhoto]
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
}

struct FlickrPhoto: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String?
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int

    var imageUrl: String {
           let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
           return urlString
       }
}
