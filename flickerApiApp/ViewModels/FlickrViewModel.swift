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
    private(set) var photoData : FlickrImageResult! {
        didSet {
            self.bindPhotoViewModelToController()
        }
    }

    var bindPhotoViewModelToController : (() -> ()) = {}

    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetPhotoData()
    }

    func callFuncToGetPhotoData() {
        self.apiService.apiToFetchFlickerData { (photoData) in
            self.photoData = photoData
        }
    }
}
