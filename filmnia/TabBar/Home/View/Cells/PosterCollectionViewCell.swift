//
//  PosterCollectionViewCell.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 19/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    var showImage = ResultsMovies(results: [])
    
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadiusPoster()
    }
    
//aqui eu transformo a url de posterPath em imagem
    func urlShowImage(path: String) {
        if let url = URL(string: path) {
            posterImage.downloadImage(from: url)
        }
    }
    
    func imageURl(from url: String) -> String {
        return Constants.urlBaseImage + "w200" + url
    }
    
//aqui eu mostro a imagem na celula definida na SearchViewController
    func cellPosterMoviesPath(dataMovie: Movies) {
        let imageUrl = imageURl(from: dataMovie.posterPath ?? "")
        urlShowImage(path: imageUrl)
    }
    
    func cellPosterTelevisionPath(dataTelevision: Television) {
        let imageUrl = imageURl(from: dataTelevision.posterPath ?? "")
        urlShowImage(path: imageUrl)
    }
    
    func cornerRadiusPoster() {
        posterImage.layer.cornerRadius = posterImage.frame.size.width/12.5
    }

}
