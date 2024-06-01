//
//  WorkTableViewCell.swift
//  PicassoApp
//
//  Created by Иван Семикин on 01/06/2024.
//

import UIKit
import Foundation

final class WorkTableViewCell: UITableViewCell {
    @IBOutlet var imageWork: UIImageView!
    @IBOutlet var titleWork: UILabel!
    
    func configure(withWork work: Work) {
        imageWork.image = UIImage(named: work.image)
        titleWork.text = work.title
    }
}
