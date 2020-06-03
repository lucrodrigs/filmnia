//
//  DetailsViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 06/03/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterMovie: UIImageView?
    @IBOutlet weak var titleMovie: UILabel?
    @IBOutlet weak var recommendationMovie: UILabel?
    @IBOutlet weak var runTime: UILabel?
    @IBOutlet weak var releaseAge: UILabel?
    @IBOutlet weak var overviewLabel: UILabel?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rateAverage: UIView!
    @IBOutlet weak var rateLabel: UILabel?
    @IBOutlet weak var progressLoad: UIActivityIndicatorView!
    
    var delegate: DetailsMovieDelegate?
    var addToListDelegate: AddItemToListDelegate?
    var resultsRequest: ResultsMovies?
    var viewModel: DetailsViewModel!
    var shapeLayer: CAShapeLayer?
    var transparentLayer: CAShapeLayer?
    var trackLayer: CAShapeLayer?
    
    init(viewModel: DetailsViewModel) {
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
        viewModel.recomendationMovies()
        viewModel.getDetailsMovie()
        viewModel.delegate = self
        viewModel.delegateAlert = self
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal.jpeg")!)
        self.collectionView.backgroundColor = .clear
    }
    
    func setupRecomendationCollectionView() {
        collectionView.register(UINib(nibName: "RecomendationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecomendationCollectionViewCell")
    }
    
    func detailsImage() {
        let urlString = Constants.urlBaseImage + "original" + (viewModel.movies.posterPath ?? "")
        if let url = URL(string: urlString) {
            posterMovie?.downloadImage(from: url, completion: {
                [weak self] in
                self?.progressLoad.stopAnimating()
            })
            posterMovie?.layer.cornerRadius = ((posterMovie?.frame.size.width)!/5.6)
        }
    }
    
    func voteAverage() {
        let voteAverage = viewModel.movies.voteAverage
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
        self.shapeLayer?.removeFromSuperlayer()
        self.shapeLayer = nil
        self.trackLayer?.removeFromSuperlayer()
        self.trackLayer = nil
        self.transparentLayer?.removeFromSuperlayer()
        self.transparentLayer = nil
        
        let shapeLayer = CAShapeLayer()
        let trackLayer = CAShapeLayer()
        let transparentLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: rateAverage.frame.size.width/2, y: rateAverage.frame.size.height/2), radius: 30, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.ColorDarkDefault.cgColor
        trackLayer.lineWidth = 15
        trackLayer.fillColor = UIColor.ColorDarkDefault.cgColor
        trackLayer.strokeEnd = 0.8
        self.trackLayer = trackLayer
        rateAverage.layer.addSublayer(trackLayer)
        
        transparentLayer.path = circularPath.cgPath
        transparentLayer.strokeColor = transparentColor
        transparentLayer.lineWidth = 5
        transparentLayer.fillColor = UIColor.clear.cgColor
        transparentLayer.strokeEnd = 0.8
        self.transparentLayer = transparentLayer
        rateAverage.layer.addSublayer(transparentLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = shapeColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        self.shapeLayer = shapeLayer
        rateAverage.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2
        animation.fromValue = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.strokeEnd = rate
        shapeLayer.add(animation, forKey: "animateProgress")
    }
    
//    func translateDetails() {
//        let offset = posterMovie?.frame.origin ?? CGPoint.zero
//        let x: CGFloat = 0, y: CGFloat = 0
//        squareBlue.transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
//        squareBlue.isHidden = false
//        UIView.animate(
//            withDuration: 1, delay: 1, usingSpringWithDamping: 0.47, initialSpringVelocity: 3,
//            options: .curveEaseOut, animations: {
//                squareBlue.transform = .identity
//                squareBlue.alpha = 1
//        })
//    }
    
    
    
    func timeMovie() {
        if let releaseTime = viewModel.details?.runtime {
            runTime?.font = UIFont(name: "Gilroy-SemiBold", size: runTime?.font.pointSize ?? 17)
            runTime?.textColor = .white
            runTime?.text = String(releaseTime / 60) + " hours " + String(releaseTime % 60) + " minutes"
        }
    }
    
    func releaseMovie() {
        let releaseDate = viewModel.details?.releaseDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: releaseDate ?? "N/A")
        releaseAge?.font = UIFont(name: "Gilroy-SemiBold", size: releaseAge?.font.pointSize ?? 17)
        releaseAge?.textColor = .white
        releaseAge?.text = date?.toString(with: .longDateDetail)
    }
    
    func overviewMovie() {
        let overview = viewModel.movies.overview
        overviewLabel?.font = UIFont(name: "Gilroy-Light", size: overviewLabel?.font.pointSize ?? 12)
        overviewLabel?.textColor = .white
        overviewLabel?.text = overview
    }
    
    func titleMovies() {
        let title = viewModel.details?.originalTitle
        titleMovie?.font = UIFont(name: "Gilroy-ExtraBold", size: titleMovie?.font.pointSize ?? 24)
        titleMovie?.textColor = .white
        titleMovie?.text = title
    }
    
    func recommendationTitle() {
        let titleRecommendation = viewModel.details?.originalTitle
        recommendationMovie?.font = UIFont(name: "Gilroy-SemiBold", size: recommendationMovie?.font.pointSize ?? 17)
        recommendationMovie?.textColor = .white
        recommendationMovie?.text = String("Recommendation for " + (titleRecommendation ?? "untitle"))
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        viewModel.markFavoriteAction()
    }
    
    @IBAction func AddlistAction(_ sender: UIButton) {
        addToListDelegate?.addItemToSelectedList(movie: viewModel.movies)
    }
    
    @IBAction func WatchedAction(_ sender: UIButton) {
        viewModel.markWatchedAction()
    }
    
    func closeDetails() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        closeDetails()
    }
    
}

extension DetailsViewController: DetailsMovieDelegate, AlertDelegate {
    
    func alertMarks(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showImagePosters(resultMovies: ResultsMovies) {
        resultsRequest = resultMovies
        collectionView.reloadData()
    }
    
    func detailsMovie() {
        detailsImage()
        timeMovie()
        releaseMovie()
        overviewMovie()
        voteAverage()
        titleMovies()
        recommendationTitle()
    }
    
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168*3/4, height: 187)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsRequest?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomendationCollectionViewCell", for: indexPath) as? RecomendationCollectionViewCell
        if let result = resultsRequest {
            cell?.cellPosterPathMovie(dataMovie: result.results[indexPath.row])
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movies = resultsRequest?.results[indexPath.row] else { return }
        viewModel.movies = movies
        viewModel.getDetailsMovie()
        viewModel.recomendationMovies()
        collectionView.reloadData()
    }
    
}
