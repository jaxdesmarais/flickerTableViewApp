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
    let searchController = UISearchController(searchResultsController: nil)
    var flickrViewModel = FlickrViewModel()
    var filteredPhotos: [FlickrPhoto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        
        callToViewModelForUIUpdate()
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "Photo")
    }
    
    func filterPhotos(for searchText: String) {
        filteredPhotos = flickrViewModel.photoData?.photos?.photo.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false } ?? []
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterPhotos(for: searchText)
            if !searchText.isEmpty {
                searchController.searchBar.showsCancelButton = true
                tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchController.isActive = false
        tableView.reloadData()
    }
    
    func callToViewModelForUIUpdate(){
        self.flickrViewModel.bindPhotoViewModelToController = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredPhotos.count
        } else {
            return flickrViewModel.photoData?.photos?.photo.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        let photos = searchController.isActive ? filteredPhotos[indexPath.row] : flickrViewModel.photoData?.photos?.photo[indexPath.row]
        if let titleText = photos?.title {
            cell.textLabel?.text = titleText
        } else {
            cell.textLabel?.text = "No value"
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.accessoryType = .disclosureIndicator
        
        if let imageUrl = photos?.imageUrl, let url = URL(string: imageUrl) {
            flickrViewModel.callFuncToGetPhotoData(url: url) { image, returnedUrl in
                if returnedUrl == url {
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        let selectedImage = selectedCell?.imageView?.image
        
        let detailViewController = ImageDetailViewController()
        detailViewController.selectedImage = selectedImage
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

class PhotoTableViewCell: UITableViewCell {
    override func prepareForReuse() {
        guard let imageView = imageView else { return }
        if imageView.image != nil {
            imageView.image = nil
        }
    }
}
