//
//  Protocols.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 18/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    func didLogin()
}

protocol HomeViewDelegate {
    func showImagePosters(resultPoster: EnumerateSection.ContentSection)
}

protocol SearchViewDelegate {
    func showImagePosters(resultPoster: ResultsMovies)
}

protocol ProfileViewDelegate {
    func showImagePosters(resultPoster: ResultsGeneral)
    func detailsProfile()
    func showLists(list: ResultList)
    func reloadLists()
}

protocol DetailsTelevisionDelegate {
    func showImagePosters(resultMovies: ResultsTelevision)
    func detailsTelevision()
}

protocol DetailsMovieDelegate {
    func showImagePosters(resultMovies: ResultsMovies)
    func detailsMovie()
}

protocol DetailsListDelegate {
    func showImagePosters(resultPoster: DetailsList)
    func detailsList()
}

protocol DetailsSelectDelegate {
    func movieSelected(movie: Movies, flux: Flux)
    func televisonSelected(televison: Television, flux: Flux)
    func listSelected(list: List)
}

extension DetailsSelectDelegate {
    func listSelected(list: List) {}
}

protocol CreateListDelegate {
    func didCreateList()
}

protocol AddItemToListDelegate {
    func addItemToSelectedList(movie: Movies)
}

protocol AlertDelegate {
    func alertMarks(title: String, message: String)
}
