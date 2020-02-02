//
//  UIImageView+Extensions.swift
//  Movies
//
//  Created by Victor Ruiz on 2/2/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.kf.setImage(with: URL(string: URLString))
    }
}
