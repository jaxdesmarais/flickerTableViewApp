//
//  ViewController.swift
//  flickerApiApp
//
//  Created by Desmarais, Jax on 9/24/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    var flickrViewModel = FlickrViewModel()
//    var photos = [FlickrViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        callToViewModelForUIUpdate()
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Photo")
    }
    
    func callToViewModelForUIUpdate(){
        self.flickrViewModel =  FlickrViewModel()
        self.flickrViewModel.bindPhotoViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (flickrViewModel.photoData.photos?.photo.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        cell.textLabel?.text = flickrViewModel.photoData.photos?.photo[indexPath.row].title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.accessoryType = .disclosureIndicator
        
        if let imageUrl = flickrViewModel.photoData.photos?.photo[indexPath.row].imageUrl, let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data {
                    DispatchQueue.main.sync {
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
}
