//
//  ArtistDetailsViewController.swift
//  PicassoApp
//
//  Created by Иван Семикин on 01/06/2024.
//

import UIKit

final class ArtistDetailsViewController: UIViewController {
    @IBOutlet var imageArtistImageView: UIImageView!
    @IBOutlet var nameArtistLabel: UILabel!
    @IBOutlet var bioArtistLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var artist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkDetailsVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let workDetailsVC = segue.destination as? WorkDetailsViewController else { return }
            workDetailsVC.work = artist.works[indexPath.row]
        }
    }
}

// MARK: - Private Methods
private extension ArtistDetailsViewController {
    func setupUI() {
        imageArtistImageView.image = UIImage(named: artist.image)
        nameArtistLabel.text = artist.name
        bioArtistLabel.text = artist.bio
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ArtistDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Картины автора:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkTableViewCell", for: indexPath) as? WorkTableViewCell
        
        cell?.configure(withWork: artist.works[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WorkDetailsVC", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
