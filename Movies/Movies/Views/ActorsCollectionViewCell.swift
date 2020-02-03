//
//  ActorsCollectionViewCell.swift
//  Movies
//
//  Created by Victor Ruiz on 2/2/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var actorName: String? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let actorName = actorName else {return}
        nameLabel.text = actorName
    }
}
