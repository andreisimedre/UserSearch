//
//  UIImageView + Extension.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func loadImageFromUrl(_ url: String) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                guard let data = image.pngData() else { return }
                self.image = UIImage(data: data)
            }
        }
    }
}
