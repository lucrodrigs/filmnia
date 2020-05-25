//
//  RecomendationCollectionViewCell.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 16/03/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class RecomendationCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadiusPoster()
    }
        
    func urlShowImage(path: String) {
        if let url = URL(string: path) {
            posterImage.downloadImage(from: url)
        }
    }
    
    func imageURl(from url: String) -> String {
        return Constants.urlBaseImage + "original" + url
    }
        
    func cellPosterPathMovie(dataMovie: Movies) {
        let imageUrl = imageURl(from: dataMovie.posterPath ?? "")
        urlShowImage(path: imageUrl)
    }
    
    func cellPosterPathTelevision(dataTelevision: Television) {
        let imageUrl = imageURl(from: dataTelevision.posterPath ?? "")
        urlShowImage(path: imageUrl)
    }
    
    func cornerRadiusPoster() {
        posterImage.layer.cornerRadius = posterImage.frame.size.width/12.5
    }

}
