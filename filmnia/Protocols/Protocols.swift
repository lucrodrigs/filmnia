//
//  Protocols.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 18/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

protocol HomeViewDelegate {
    func showImagePosters(resultPoster: ContentSection)
}

protocol SearchViewDelegate {
    func showImagePosters(resultPoster: ResultsMovies)
}

protocol DetailsSelectDelegate {
    func movieSelected(movie: Movies/*, flux: Flux*/)
    func televisonSelected(televison: Television)
}

protocol DetailsTelevisionDelegate {
    func showImagePosters(resultMovies: ResultsTelevision)
    func detailsTelevision()
}

protocol DetailsMovieDelegate {
    func showImagePosters(resultMovies: ResultsMovies)
    func detailsMovie()
}
