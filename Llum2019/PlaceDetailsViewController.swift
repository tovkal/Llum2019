//
//  PlaceDetailsViewController.swift
//  Llum2019
//
//  Created by Andrés Pizá Bückmann on 14/02/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import Kingfisher

class PlaceDetailsViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!

    private var place: Place?

    func display(_ place: Place) {
        self.place = place
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        guard let place = place else {
            dismiss(animated: true, completion: nil)
            return
        }

        if let image = place.image, let url = URL(string: image) {
            imageView.kf.setImage(with: url)
        }

        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
    }
}
