//
//  WorkDetailsViewController.swift
//  PicassoApp
//
//  Created by Иван Семикин on 01/06/2024.
//

import UIKit

final class WorkDetailsViewController: UIViewController {
    @IBOutlet var titleWorkLabel: UILabel!
    @IBOutlet var imageWorkImageView: UIImageView!
    @IBOutlet var infoWorkLabel: UILabel!
    
    var work: Work!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func closeButtonPressed() {
        dismiss(animated: true)
    }
}

extension WorkDetailsViewController {
    private func setupUI() {
        titleWorkLabel.text = work.title
        imageWorkImageView.image = UIImage(named: work.image)
        infoWorkLabel.text = work.info
    }
}
