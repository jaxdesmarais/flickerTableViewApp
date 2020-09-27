//
//  ViewController.swift
//  flickerApiApp
//
//  Created by Desmarais, Jax on 9/24/20.
//  Copyright © 2020 Desmarais, Jax. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var flickerViewModel = FlickrViewModel()
//    private var dataSource : PhotoTableViewDataSource<PhotoTableViewCell,Photos>!
    
	let tableView = UITableView()
    var photos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
//        tableView.delegate = self
//        tableView.dataSource = self
        
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Photos")
    }
    
    func callToViewModelForUIUpdate(){
        
        self.flickerViewModel =  FlickrViewModel()
        self.flickerViewModel.bindPhotoViewModelToController = {
//            self.updateDataSource()
        }
    }
    
//    func updateDataSource(){
        
//        self.dataSource = PhotoTableViewDataSource(cellIdentifier: "PhotoTableViewCell", items: self.flickerViewModel.photoData.data, configureCell: { (cell, photoVM) in
//            cell.photoIdLabel.text = photoVM.title
//            cell.employeeNameLabel.text = evm.employeeName
//        })
        
//        DispatchQueue.main.async {
//            self.tableView.dataSource = self
//            self.tableView.reloadData()
//        }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photos", for: indexPath)
		return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
