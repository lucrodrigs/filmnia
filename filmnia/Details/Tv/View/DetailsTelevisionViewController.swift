//
//  DetailsTelevisionViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 15/04/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class DetailsTelevisionViewController: UIViewController {

    @IBOutlet weak var posterTelevision: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recommendationTitle: UILabel?
    @IBOutlet weak var overviewTelevision: UILabel?
    @IBOutlet weak var releaseAge: UILabel?
    @IBOutlet weak var releaseSeasons: UILabel?
    @IBOutlet weak var titleTelevision: UILabel?
    @IBOutlet weak var rateLabel: UILabel?
    @IBOutlet weak var rateAverage: UIView!
    
    var delegate: DetailsMovieDelegate?
    var resultsRequest: ResultsTelevision?
    var viewModel: DetailsTelevisionViewModel!
    
    init(viewModel: DetailsTelevisionViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setupRecomendationCollectionView()
        viewModel.recomendationTelevision()
        viewModel.getDetailsTelevision()
        viewModel.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal.jpeg")!)
        self.collectionView.backgroundColor = .clear
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
    
    func voteAverage() {
        let voteAverage = viewModel.television.voteAverage
        let voteString = String(voteAverage)
        let shapeColor: CGColor
        let transparentColor: CGColor
        rateLabel?.font = UIFont(name: "Gilroy-SemiBold", size: rateLabel?.font.pointSize ?? 17)
        
        if voteAverage < 4.0 {
            shapeColor = UIColor.ColorLightRed.cgColor
            transparentColor = UIColor.ColorDarkRed.cgColor
            rateLabel?.text = voteString.replacingOccurrences(of: ".", with: "") + "%"
        } else if voteAverage < 7.0 {
            shapeColor = UIColor.ColorLightYellow.cgColor
            transparentColor = UIColor.ColorDarkYellow.cgColor
            rateLabel?.text = voteString.replacingOccurrences(of: ".", with: "") + "%"
        } else {
            shapeColor = UIColor.ColorLightGreen.cgColor
            transparentColor = UIColor.ColorDarkGreen.cgColor
            rateLabel?.text = voteString.replacingOccurrences(of: ".", with: "") + "%"
        }

        let rateFinal = CGFloat(voteAverage / 10) * 0.8
        createRateAverage(rate: rateFinal, transparentColor: transparentColor, shapeColor: shapeColor)
    }
    
    func createRateAverage(rate: CGFloat, transparentColor: CGColor, shapeColor: CGColor){
        let shapeLayer = CAShapeLayer()
        let trackLayer = CAShapeLayer()
        let transparentLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: rateAverage.frame.size.width/2, y: rateAverage.frame.size.height/2), radius: 30, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.ColorDarkDefault.cgColor
        trackLayer.lineWidth = 15
        trackLayer.fillColor = UIColor.ColorDarkDefault.cgColor
        trackLayer.strokeEnd = 0.8
        rateAverage.layer.addSublayer(trackLayer)
        
        transparentLayer.path = circularPath.cgPath
        transparentLayer.strokeColor = transparentColor
        transparentLayer.lineWidth = 5
        transparentLayer.fillColor = UIColor.clear.cgColor
        transparentLayer.strokeEnd = 0.8
        rateAverage.layer.addSublayer(transparentLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = shapeColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        rateAverage.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2
        animation.fromValue = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.strokeEnd = rate
        shapeLayer.add(animation, forKey: "animateProgress")
    }
    
    func animateView() {
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(
            withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.view.transform = .identity
                self.view.alpha = 1
        }, completion: nil)
    }
    
    func televisionTitle() {
        let title = viewModel.television.name
        titleTelevision?.font = UIFont(name: "Gilroy-ExtraBold", size: titleTelevision?.font.pointSize ?? 24)
        titleTelevision?.textColor = .white
        titleTelevision?.text = title
    }
    
    func countSeasons() {
        let seasons = viewModel.details?.numberOfSeasons
        releaseSeasons?.font = UIFont(name: "Gilroy-SemiBold", size: releaseSeasons?.font.pointSize ?? 17)
        releaseSeasons?.textColor = .white
        releaseSeasons?.text = String(seasons ?? 0) + " seasons"
    }
    
    func releaseDate() {
        let release = viewModel.television.firstAirDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: release)
        releaseAge?.font = UIFont(name: "Gilroy-SemiBold", size: releaseAge?.font?.pointSize ?? 17)
        releaseAge?.textColor = .white
        releaseAge?.text = "First episode in air on " + (date?.toString(with: .longDateDetail) ?? "N/A")
    }
    
    func overview() {
        overviewTelevision?.font = UIFont(name: "Gilroy-Light", size: overviewTelevision?.font.pointSize ?? 12)
        overviewTelevision?.textColor = .white
        overviewTelevision?.text = viewModel.television.overview
    }
    
    func titleRecommendations() {
        recommendationTitle?.font = UIFont(name: "Gilroy-SemiBold", size: recommendationTitle?.font.pointSize ?? 17)
        recommendationTitle?.textColor = .white
        recommendationTitle?.text = "Recommendations for " + viewModel.television.name
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        viewModel.markFavoriteAction()
    }
    
    @IBAction func AddlistAction(_ sender: UIButton) {
        
    }
    
    @IBAction func WatchedAction(_ sender: UIButton) {
        viewModel.markWatchedAction()
    }
    
    func closeDetails() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        closeDetails()
    }
    
}

extension DetailsTelevisionViewController: DetailsTelevisionDelegate {
    
    func showImagePosters(resultMovies: ResultsTelevision) {
        resultsRequest = resultMovies
        collectionView.reloadData()
    }
    
    func detailsTelevision() {
        detailsImage()
        voteAverage()
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
        viewModel?.getDetailsTelevision()
        viewModel.recomendationTelevision()
        collectionView.reloadData()
        animateView()
    }
    
}
