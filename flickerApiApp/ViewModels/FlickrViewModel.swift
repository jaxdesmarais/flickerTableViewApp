//
//  FlickrViewModel.swift
//  flickerApiApp
//
//  Created by Jax DesMarais-Leder on 9/26/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import UIKit

class FlickrViewModel: NSObject {
    private var apiService : APIService!
    public var photoData : FlickrImageResult? {
        didSet {
            self.bindPhotoViewModelToController()
        }
    }

    var bindPhotoViewModelToController : (() -> ()) = {}

    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetFlickrData(text: "")
    }

    func callFuncToGetFlickrData(text: String) {
        self.apiService.apiToFetchFlickerData(text: text) { (photoData) in
            self.photoData = photoData
        }
    }
    func callFuncToGetPhotoData(url: URL, completion: @escaping (UIImage?, URL) -> ()) {
        self.apiService.apiToFetchPhotoData(url: url) { (imageData) in
            completion(imageData, url)
        }
    }
}
