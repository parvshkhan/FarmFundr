//
//  UIImageViewExtension.swift
//  FarmFundr
//
//  Created by Anupriya on 09/10/18.
//  Copyright © 2018 smartitventures.com. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
   
}


