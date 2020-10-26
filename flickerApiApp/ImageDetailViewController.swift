//
//  ImageDetailViewController.swift
//  flickerApiApp
//
//  Created by Desmarais, Jax on 10/15/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    var imageView = UIImageView()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        view.backgroundColor = .white
        
        if let imageToLoad = selectedImage {
            imageView.image = imageToLoad
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
