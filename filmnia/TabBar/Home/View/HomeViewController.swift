//
//  HomeViewController.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 19/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

typealias CollectionSection = HomeViewController.Section

class HomeViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case popular = 0
        case upComing
        case nowPlaying
        
        var titleSectionsMovies: String {
            switch self {
            case .popular:
                return " Popular Movies"
            case .upComing:
                return " Upoming Movies"
            case .nowPlaying:
                return " Now Playing Movies"
            }
        }
        
        var titleSectionsTelevision: String {
            switch self {
            case .popular:
                return " Popular Series"
            case .upComing:
                return " Top Rated Series"
            case .nowPlaying:
                return " On The Air "
            }
        }
        
        var height: CGFloat {
            switch self {
            case .popular:
                return 278
            default:
                return 187
            }
        }
        
        var sizeCollectionCell: CGSize {
            switch self {
            case .popular:
                return CGSize(width: 187, height: height)
            default:
                return CGSize(width: 168*3/4, height: height)
            }
        }
        
    }
    
    //MARK: - Variables
    var viewModel = HomeViewModel()
    var delegate: DetailsSelectDelegate?
    //var enumerateSection: EnumerateSection?
    var popularMovies = ResultsMovies(results: [])
    var upComingMovies = ResultsMovies(results: [])
    var nowPlayingMovies = ResultsMovies(results: [])
    var popularTelevision = ResultsTelevision(results: [])
    var topRatedTelevison = ResultsTelevision(results: [])
    var onTheAirTelevision = ResultsTelevision(results: [])
    
    //MARK: - Outlets
    @IBOutlet weak var tableViewHome: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl?
    
    @IBAction func indexChanged(_ sender: Any?) {
        switch segmentedControl?.selectedSegmentIndex {
        case 0:
            viewModel.resultPosterGetMoviesPopulars()
            viewModel.resultPosterGetUpComing()
            viewModel.resultPosterNowPlaying()
        case 1:
            viewModel.resultPosterGetTvPopulars()
            viewModel.resultPosterGetOnTheAir()
            viewModel.resultPosterGetTopRated()
        default:
            break
        }
            tableViewHome.reloadData()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.resultPosterGetMoviesPopulars()
        viewModel.resultPosterGetUpComing()
        viewModel.resultPosterNowPlaying()
        viewModel.resultPosterGetTvPopulars()
        viewModel.resultPosterGetOnTheAir()
        viewModel.resultPosterGetTopRated()
        viewModel.delegate = self
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
    }
    
    private func setupTableView() {
        tableViewHome.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        //ACHAR PROBLEMA NO COUNT
        //case0: viewModel.resultSectionTelevision.count
        //case1: viewModel.resultSectionMovies.count
        
        switch segmentedControl?.selectedSegmentIndex {
        case 0:
            return 3
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        title.font = UIFont(name: "Gilroy-SemiBold", size: title.font.pointSize)
        
        switch segmentedControl?.selectedSegmentIndex {
        case 0:
            title.text = Section.allCases[section].titleSectionsMovies
        case 1:
            title.text = Section.allCases[section].titleSectionsTelevision
        default:
            break
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Section(rawValue: indexPath.section)
        return section?.height ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewHome.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell, let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        cell.setupCollectionView(view: self)
        cell.delegate = self
        
        switch segmentedControl?.selectedSegmentIndex {
        case 0:
            switch section {
            case .popular:
                cell.updateSetupMovie(result: popularMovies, section: section)
            case .upComing:
                cell.updateSetupMovie(result: upComingMovies, section: section)
            case .nowPlaying:
                cell.updateSetupMovie(result: nowPlayingMovies, section: section)
            }
        case 1:
            switch section {
            case .popular:
                cell.updateSetupTelevision(result: popularTelevision, section: section)
            case .upComing:
                cell.updateSetupTelevision(result: topRatedTelevison, section: section)
            case .nowPlaying:
                cell.updateSetupTelevision(result: onTheAirTelevision, section: section)
            }
        default:
            break
        }
        cell.reloadData()
        return cell
    }
}

extension HomeViewController: HomeViewDelegate, DetailsSelectDelegate {
    
    func televisonSelected(televison: Television) {
        delegate?.televisonSelected(televison: televison)
    }
    
    func movieSelected(movie: Movies) {
        delegate?.movieSelected(movie: movie)
    }
    
    func showImagePosters(resultPoster: ContentSection) {
        
            switch resultPoster {
            case .moviesPopular(let result):
                popularMovies = result
            case .moviesUpComing(let result):
                upComingMovies = result
            case .moviesNowPlaying(let result):
                nowPlayingMovies = result
            case .televisionPopular(let result):
                popularTelevision = result
            case .televisionTopRated(let result):
                topRatedTelevison = result
            case .televisionOnTheAir(let result):
                onTheAirTelevision = result
            }
            
    tableViewHome.reloadData()
        
    }
}
