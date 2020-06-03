//
//  UIImage.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 19/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

extension UIImageView {
    typealias funcaoRetorno = () -> Void
    
    func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: (() -> Void)? = nil) {
        getData(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async() {
                self.image = image
                completion?()
            }
        }
    }
    
}
