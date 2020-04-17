//
//  DetailsTelevisionViewController.swift
//  filmnia
//
//  Created by UserTQI on 15/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class DetailsTelevisionViewController: UIViewController {

    @IBOutlet weak var posterTelevision: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recommendationTitle: UILabel?
    @IBOutlet weak var overviewTelevision: UILabel?
    @IBOutlet weak var releaseAge: UITextField?
    @IBOutlet weak var releaseSeasons: UILabel?
    @IBOutlet weak var titleTelevision: UILabel?
    
    var delegate: DetailsDelegate?
    var resultsRequest: ResultsTelevision?
    var viewModel: DetailsTelevisionViewModel!
    
    init(viewModel: DetailsTelevisionViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecomendationCollectionView()
        viewModel.recomendationTelevision()
        viewModel.detailsTelevision()
        viewModel.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupRecomendationCollectionView() {
        collectionView.register(UINib(nibName: "RecomendationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecomendationCollectionViewCell")
    }
    
    func detailsImage() {
        let urlString = Constants.urlBaseImage + "original" + (viewModel?.television.posterPath ?? "")
        if let url = URL(string: urlString) {
            posterTelevision?.downloadImage(from: url)
            posterTelevision?.layer.cornerRadius = ((posterTelevision?.frame.size.width)!/12)
        }
    }
    
    func televisionTitle() {
        let title = viewModel.television.name
        titleTelevision?.text = title
    }
    
    func countSeasons() {
        let seasons = viewModel.details?.numberOfSeasons
        releaseSeasons?.text = String(seasons ?? 0) + " seasons"
    }
    
    func releaseDate() {
        let release = viewModel.television.firstAirDate
        releaseAge?.text = "First episode in air on " + release
    }
    
    func overview() {
        let overview = viewModel.television.overview
        overviewTelevision?.text = overview
    }
    
    func titleRecommendations() {
        let recommendations = viewModel.television.name
        recommendationTitle?.text = "Recommendations for " + recommendations
    }

}

extension DetailsTelevisionViewController: DetailsTelevisionDelegate {
    
    func showImagePosters(resultMovies: ResultsTelevision) {
        resultsRequest = resultMovies
        collectionView.reloadData()
    }
    
    func detailsTelevision() {
        detailsImage()
        televisionTitle()
        countSeasons()
        releaseDate()
        overview()
        titleRecommendations()
    }
    
}

extension DetailsTelevisionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168*3/4, height: 187)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsRequest?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendationCollectionViewCell", for: indexPath) as? RecomendationCollectionViewCell
        if let result = resultsRequest {
            cell?.cellPosterPathTelevision(dataTelevision: result.results[indexPath.row])
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let television = resultsRequest?.results[indexPath.row] else { return }
        viewModel?.television = television
        viewModel?.detailsTelevision()
        viewModel.recomendationTelevision()
        collectionView.reloadData()
    }
    
}
