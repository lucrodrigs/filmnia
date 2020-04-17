//
//  AppCoordinator.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 18/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

protocol Coordinator {
    
}

class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var viewTabBar: UITabBarController
    var navDetails: FNavigationViewController?
    
    init(window: UIWindow) {
        self.window = window
        viewTabBar = UITabBarController()
        viewTabBar.view.backgroundColor = .white
        window.rootViewController = viewTabBar
        window.makeKeyAndVisible()
    }
    
    func start() {
        viewTabBar.viewControllers = [initTabBarHome(),
                                      initTabBarSearch(),
                                      initTabBarWatchlist(),
                                      initTabBarWatched()]
    }
    
    func initTabBarHome() -> FNavigationViewController {
        let tabView = HomeViewController()
        tabView.delegate = self
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "house.fill")
        navigation.tabBarItem.title = "Home"
        navDetails = navigation
        return navigation
    }
    
    func initTabBarSearch() -> FNavigationViewController {
        let tabView = SearchViewController()
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigation.tabBarItem.title = "Search"
        //tabView.delegate = self
        return navigation
    }
    
    func initTabBarWatchlist() -> FNavigationViewController {
        let tabView = WatchlistViewController()
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "person.fill")
        navigation.tabBarItem.title = "+ Watchlist"
        return navigation
    }
    
    func initTabBarWatched() -> FNavigationViewController {
        let tabView = WatchedViewController()
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "person.fill")
        navigation.tabBarItem.title = "+ Wacthed"
        return navigation
    }
    
    func detailsMovieViewControler(model: Movies) {
        let viewModel = DetailsViewModel(movies: model)
        let detailsView = DetailsViewController(viewModel: viewModel)
        navDetails?.pushViewController(detailsView, animated: true)
    }
    
    func detailsTelevisionViewControler(model: Television) {
        let viewModel = DetailsTelevisionViewModel(television: model)
        let detailsView = DetailsTelevisionViewController(viewModel: viewModel)
        navDetails?.pushViewController(detailsView, animated: true)
    }
    
    func setupProfileView() {
//        let viewModel = ProfileViewModel()
//        let profileView = ProfileViewController(model: viewModel)
//        navDetails?.pushViewController(profileView, animated: true)
    }
    
}
 
extension AppCoordinator: DetailsSelectDelegate, HomeCoordinatorDelegate {
    
    func toGoProfile() {
    }
    
    func televisonSelected(televison: Television) {
        detailsTelevisionViewControler(model: televison)
    }
    
    func movieSelected(movie: Movies) {
        detailsMovieViewControler(model: movie)
    }
    
}
