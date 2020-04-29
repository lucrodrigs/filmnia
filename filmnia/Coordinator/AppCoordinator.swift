//
//  AppCoordinator.swift
//  filmnia
//
//  Created by Lucas Rodrigues Dias on 18/02/20.
//  Copyright © 2020 lucrodrigs. All rights reserved.
//

import UIKit

enum Flux {
    case home
    case search
}

class AppCoordinator {
    
    var window: UIWindow
    var viewTabBar: UITabBarController
    var navigation: FNavigationViewController?
    var searchNavigation: FNavigationViewController?
    var homeNavigation: FNavigationViewController?
    
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
                                      initTabBarProfile()]
    }
    
    func initTabBarHome() -> FNavigationViewController {
        let tabView = HomeViewController()
        tabView.delegate = self
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "house.fill")
        navigation.tabBarItem.title = "Home"
        //homeNavigation = navigation
        self.navigation = navigation
        return navigation
    }
    
    func initTabBarSearch() -> FNavigationViewController {
        let tabView = SearchViewController()
        tabView.delegate = self
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigation.tabBarItem.title = "Search"
        searchNavigation = navigation
        return navigation
    }
    
    func initTabBarProfile() -> FNavigationViewController {
        let tabView = ProfileViewController()
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "person.fill")
        navigation.tabBarItem.title = "Profile"
        return navigation
    }
    
    func detailsMovieViewControler(model: Movies/*, flux: Flux*/) {
        let viewModel = DetailsViewModel(movies: model)
        let detailsView = DetailsViewController(viewModel: viewModel)
        navigation?.pushViewController(detailsView, animated: true)
    }
    
    func detailsTelevisionViewControler(model: Television) {
        let viewModel = DetailsTelevisionViewModel(television: model)
        let detailsView = DetailsTelevisionViewController(viewModel: viewModel)
        navigation?.pushViewController(detailsView, animated: true)
    }
    
}
 
extension AppCoordinator: DetailsSelectDelegate {
    
    func televisonSelected(televison: Television) {
        detailsTelevisionViewControler(model: televison)
    }
    
    func movieSelected(movie: Movies/*, flux: Flux*/) {
        detailsMovieViewControler(model: movie/*, flux: flux*/)
    }
    
}
