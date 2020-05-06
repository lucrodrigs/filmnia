//
//  TableViewCell.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 26/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

//SectionsTableViewCell

class TableViewCell: UITableViewCell {
    
    var resultsRequestMovie: ResultsMovies?
    var resultsRequestTelevison: ResultsTelevision?
    var section: CollectionSection?
    var delegate: DetailsSelectDelegate?
    var homeView: HomeViewController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    func setupCollectionView(view: HomeViewController) {
        collectionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "PosterCollectionViewCell")
        homeView = view
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func setResultRequestMovie(result: ResultsMovies) {
        resultsRequestMovie = result
        collectionView.reloadData()
    }
    
    func setResultRequestTelevison(result: ResultsTelevision) {
        resultsRequestTelevison = result
        collectionView.reloadData()
    }
    
    func updateSetupMovie(result: ResultsMovies, section: CollectionSection) {
        self.section = section
        setResultRequestMovie(result: result)
    }
    
    func updateSetupTelevision(result: ResultsTelevision, section: CollectionSection) {
        self.section = section
        setResultRequestTelevison(result: result)
    }
    
}

//aqui eu tenho a quantidade de celulas exibidas e aonde minha celula esta percorrendo com as url de posterPath
extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return section?.sizeCollectionCell ?? CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch homeView?.segmentedControl?.selectedSegmentIndex {
            case 0:
                return resultsRequestMovie?.results.count ?? 0
            case 1:
                return resultsRequestTelevison?.results.count ?? 0
            default:
                return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as? PosterCollectionViewCell
        
        if let result = resultsRequestMovie {
            cell?.cellPosterMoviesPath(dataMovie: result.results[indexPath.row])
        }
        
        switch homeView?.segmentedControl?.selectedSegmentIndex {
        case 0:
            if let result = resultsRequestMovie {
                cell?.cellPosterMoviesPath(dataMovie: result.results[indexPath.row])
            }
        case 1:
            if let result = resultsRequestTelevison {
                cell?.cellPosterTelevisionPath(dataTelevision: result.results[indexPath.row])
            }
        default:
            break
        }
        
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch homeView?.segmentedControl?.selectedSegmentIndex {
        case 0:
            guard let movies = resultsRequestMovie?.results[indexPath.row] else { return }
            delegate?.movieSelected(movie: movies)
        case 1:
            guard let television = resultsRequestTelevison?.results[indexPath.row] else { return }
            delegate?.televisonSelected(televison: television)
        default:
            break
        }
        
    }
    
}
