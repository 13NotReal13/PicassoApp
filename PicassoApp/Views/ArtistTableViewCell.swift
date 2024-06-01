//
//  ArtistTableViewCell.swift
//  PicassoApp
//
//  Created by Иван Семикин on 01/06/2024.
//

import UIKit
import Foundation

final class ArtistTableViewCell: UITableViewCell {
    @IBOutlet var nameArtistLabel: UILabel!
    @IBOutlet var bioArtistLabel: UILabel!
    @IBOutlet var imageArtistImageView: UIImageView!
    
    func configure(withArtist artist: Artist) {
        nameArtistLabel.text = artist.name
        bioArtistLabel.text = artist.bio
        imageArtistImageView.image = UIImage(named: artist.image)
    }
}
