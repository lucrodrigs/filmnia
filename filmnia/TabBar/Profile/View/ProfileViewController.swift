//
//  ProfileViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 16/03/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableViewYourlist: UITableView!
    
    var createdlistButton: UIButton!
    var delegate: ProfileViewDelegate?
    var didSelectDelegate: DetailsSelectDelegate?
    var didSelectListDelegate: DetailsListSelectDelegate?
    var viewModel: ProfileViewModel?
    var resultsProfile: DetailsProfile?
    var resultsGeneral: ResultsGeneral?
    var resultsLists: ResultList?
    var resultsList = ResultList(results: [])

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl?.selectedSegmentIndex {
        case 0:
            tableViewYourlist.isHidden = true
            collectionView.isHidden = false
            viewModel?.showFavoritesMovies()
            viewModel?.showFavoritesTelevision()
        case 1:
            tableViewYourlist.isHidden = true
            collectionView.isHidden = false
            viewModel?.showWatchedlistMovies()
            viewModel?.showWatchedlistTelevision()
        case 2:
            tableViewYourlist.isHidden = false
            collectionView.isHidden = true
            viewModel?.showYourlists()
        default:
            break
        }
    }
    
    init(viewModel: ProfileViewModel) {
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
        setupTableView()
        setupProfileCollectionCell()
        viewModel?.getDetailsProfile()
        viewModel?.showFavoritesMovies()
        viewModel?.showFavoritesTelevision()
        viewModel?.delegate = self
        tableViewYourlist.tableFooterView = footer()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableViewYourlist.delegate = self
        tableViewYourlist.dataSource = self
        tableViewYourlist.isHidden = true
        viewModelReload()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal")!)
        self.collectionView.backgroundColor = .clear
        self.tableViewYourlist.backgroundColor = .clear
    }
    
    private func setupTableView() {
        tableViewYourlist.register(UINib(nibName: "YourlistTableViewCell", bundle: nil), forCellReuseIdentifier: "YourlistTableViewCell")
    }
    
    func setupProfileCollectionCell() {
        collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
    }
    
    func viewModelReload() {
        collectionView.reloadData()
        collectionView.backgroundView = nil
    }
    
    func nameProfile() {
        fullName.text = viewModel?.profile?.name
        fullName.font = UIFont(name: "Gilroy-SemiBold", size: fullName.font.pointSize)
        fullName.textColor = .white
    }
    
    func usernameProfile() {
        username.text = viewModel?.profile?.username
        username.font = UIFont(name: "Gilroy-Light", size: username.font.pointSize)
        username.textColor = .white
    }
    
    @objc func createdlistAction(_ sender: UIButton) {
      print("CALL")
    }
    
    func footer() -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        footer.backgroundColor = .clear
        createdlistButton = UIButton(frame: CGRect(x: 0, y: 10, width: footer.frame.width/2, height: 40))
        createdlistButton.center = footer.center
        createdlistButton.backgroundColor = .white
        createdlistButton.setTitleColor(.ColorGrayDefault, for: .normal)
        createdlistButton.setTitle("created new list", for: .normal)
        createdlistButton.titleLabel?.font = UIFont(name: "Gilroy-SemiBold", size: 16)
        createdlistButton.layer.cornerRadius = createdlistButton.frame.size.width/15
        createdlistButton.addTarget(self, action: #selector(createdlistAction), for: .touchUpInside)
        
        footer.addSubview(createdlistButton)
        return footer
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewYourlist.dequeueReusableCell(withIdentifier: "YourlistTableViewCell") as? YourlistTableViewCell
        cell?.setup(data: resultsList.results[indexPath.row])
        cell?.backgroundColor = .clear
        return cell ?? TableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let lists = resultsList.results[indexPath.row]
        didSelectListDelegate?.listSelected(list: lists)
        
    }
    
}

extension ProfileViewController: DetailsListSelectDelegate {
    
    func listSelected(list: List) {
        didSelectListDelegate?.listSelected(list: list)
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 123, height: 187)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsGeneral?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell
        
        if let result = resultsGeneral {
        cell?.cellPosterPath(data: result.results[indexPath.row])
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = resultsGeneral?.results[indexPath.row] else { return }
        generalSelected(model: details, flux: .profile)
    }
    
}

extension ProfileViewController: ProfileViewDelegate, DetailsSelectDelegate {

    func showLists(list: ResultList) {
        self.resultsList = list
        tableViewYourlist.reloadData()
    }
    
    func showImagePosters(resultPoster: ResultsGeneral) {
        resultsGeneral = resultPoster
        collectionView.reloadData()
    }
    
    func detailsProfile() {
        nameProfile()
        usernameProfile()
    }
    
    func movieSelected(movie: Movies, flux: Flux) {
        didSelectDelegate?.movieSelected(movie: movie, flux: flux)
    }
    
    func televisonSelected(televison: Television, flux: Flux) {
        didSelectDelegate?.televisonSelected(televison: televison, flux: flux)
    }
    
    func generalSelected(model: ResultsAllType, flux: Flux) {
        switch model.type {
        case .movie:
            didSelectDelegate?.movieSelected(movie: toMovie(model), flux: flux)
        case .television:
            didSelectDelegate?.televisonSelected(televison: toTelevision(model), flux: flux)
        case .none: break
        }
    }
    
    func toTelevision(_ model: ResultsAllType) -> Television {
        return Television(id: model.id ?? 0, name: model.name ?? "", firstAirDate: model.firstAirDate ?? "",
                          voteAverage: model.voteAverage ?? 0, overview: model.overview ?? "",
                          posterPath: model.posterPath)
    }
    
    func toMovie(_ model: ResultsAllType) -> Movies {
        return Movies(id: model.id ?? 0, title: model.title ?? "", posterPath: model.posterPath ?? "", overview: model.overview ?? "", releaseDate: model.releaseDate ?? "", page: model.page ?? 0, voteAverage: model.voteAverage ?? 0)
    }
    
}
