//
//  YourlistViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 21/05/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class YourlistViewController: UIViewController {
    
    @IBOutlet weak var namelist: UILabel!
    @IBOutlet weak var descriptionlist: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: DetailsListDelegate?
    var didSelectDelegate: DetailsSelectDelegate?
    var viewModel: YourlistViewModel?
    var resultRequest: DetailsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setupYourlistCollectionCell()
        viewModel?.getDetailsList()
        viewModel?.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal.jpeg")!)
        self.collectionView.backgroundColor = .clear
    }
    
    init(viewModel: YourlistViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func setupYourlistCollectionCell() {
        collectionView.register(UINib(nibName: "YourlistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YourlistCollectionViewCell")
    }
    
    func listName() {
        namelist.textColor = .white
        namelist.font = UIFont(name: "Gilroy-SemiBold", size: namelist.font.pointSize)
        namelist.text = viewModel?.detailslist?.name
    }
    
    func descriptionList() {
        descriptionlist.textColor = .white
        descriptionlist.font = UIFont(name: "Gilroy-Light", size: descriptionlist.font.pointSize)
        descriptionlist.text = viewModel?.detailslist?.description
    }
    
    func closeDetails() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        closeDetails()
    }
    
}

extension YourlistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 123, height: 187)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultRequest?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourlistCollectionViewCell", for: indexPath) as? YourlistCollectionViewCell
        
        if let result = resultRequest {
            cell?.cellPosterPath(dataMovie: result.items[indexPath.row])
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = resultRequest?.items[indexPath.row] else { return }
        generalSelected(model: details, flux: .yourlist)
    }
    
}

extension YourlistViewController: DetailsListDelegate {

    func detailsList() {
        listName()
        descriptionList()
    }
    
    func showImagePosters(resultPoster: DetailsList) {
        resultRequest = resultPoster
        collectionView.reloadData()
    }
    
    func generalSelected(model: Item, flux: Flux) {
        switch model.mediaType {
        case .movie:
            didSelectDelegate?.movieSelected(movie: toMovie(model), flux: flux)
        case .tv:
            didSelectDelegate?.televisonSelected(televison: toTelevision(model), flux: flux)
        case .none: break
        }
    }
    
    func toTelevision(_ model: Item) -> Television {
        return Television(id: model.id ?? 0, name: model.name ?? "", firstAirDate: model.firstAirDate ?? "",
                          voteAverage: model.voteAverage ?? 0, overview: model.overview ?? "",
                          posterPath: model.posterPath)
    }
    
    func toMovie(_ model: Item) -> Movies {
        return Movies(id: model.id ?? 0, title: model.title ?? "", posterPath: model.posterPath ?? "", overview: model.overview ?? "", releaseDate: model.releaseDate ?? "", voteAverage: model.voteAverage ?? 0)
    }
    
}
