//
//  ArtistListController.swift
//  PicassoApp
//
//  Created by Иван Семикин on 01/06/2024.
//

import UIKit

final class ArtistListController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private let artistService = ArtistService.shared
    private var artists: [Artist] = []
    
    private let searchController = UISearchController()
    private var filteredArtists: [Artist] = []
    private var seatchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !seatchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtists()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArtistDetailsVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let artistDetailsVC = segue.destination as? ArtistDetailsViewController else { return }
            
            let artist = isFiltering ? filteredArtists[indexPath.row] : artists[indexPath.row]
            artistDetailsVC.artist = artist
        }
    }
}

// MARK: - Private Methods
private extension ArtistListController {
    private func fetchArtists() {
        artistService.fetch { result in
            DispatchQueue.main.async { [unowned self] in
                switch result {
                case .success(let artists):
                    self.artists = artists
                    tableView.reloadData()
                case .failure(let error):
                    print("Error fetching artists: \(error.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ArtistListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            filteredArtists.count
        } else {
            artists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ArtistTableViewCell",
            for: indexPath
        ) as? ArtistTableViewCell
        
        let target = isFiltering ? filteredArtists[indexPath.row] : artists[indexPath.row]
        cell?.configure(withArtist: target)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ArtistDetailsVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ArtistListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            filteredArtists = artists
            tableView.reloadData()
            return
        }
        
        filteredArtists = artists.filter { artist in
            let doesArtistMatch = artist.name.lowercased().contains(searchText)
            let doesWorkMatch = artist.works.contains { work in
                work.title.lowercased().contains(searchText)
            }
            return doesArtistMatch || doesWorkMatch
        }
        
        tableView.reloadData()
    }
}
