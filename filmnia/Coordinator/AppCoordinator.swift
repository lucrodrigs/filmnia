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
    case profile
    case yourlist
}

class AppCoordinator {
    
    var window: UIWindow
    var viewTabBar: FTabBarViewController
    var navigation: FNavigationViewController?
    var searchNavigation: FNavigationViewController?
    var homeNavigation: FNavigationViewController?
    var profileNavigation: FNavigationViewController?
    
    init(window: UIWindow) {
        self.window = window
        viewTabBar = FTabBarViewController()
        viewTabBar.view.backgroundColor = .blue
    }
    
    func start() {
        if Session.shared.sucess {
            window.rootViewController = viewTabBar
            viewTabBar.viewControllers = [initTabBarHome(),
                                          initTabBarSearch(),
                                          initTabBarProfile(model: DetailsProfile())]
        } else {
            let login = LoginViewController()
            window.rootViewController = login
            login.viewModel.coordinatorDelegate = self
        }
        window.makeKeyAndVisible()
    }
    
    
    func initTabBarHome() -> FNavigationViewController {
        let tabView = HomeViewController()
        tabView.delegate = self
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "house.fill")
        navigation.tabBarItem.title = "Home"
        homeNavigation = navigation
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
    
    func initTabBarProfile(model: DetailsProfile) -> FNavigationViewController {
        let viewModel = ProfileViewModel(profile: model)
        let tabView = ProfileViewController(viewModel: viewModel)
        tabView.didSelectDelegate = self
        tabView.didCreateDelegate = self
        let navigation = FNavigationViewController(rootViewController: tabView)
        navigation.tabBarItem.image = UIImage(systemName: "person.fill")
        navigation.tabBarItem.title = "Profile"
        profileNavigation = navigation
        return navigation
    }
    
    func detailsMovieViewController(model: Movies, flux: Flux) {
        let viewModel = DetailsViewModel(movies: model)
        let detailsView = DetailsViewController(viewModel: viewModel)
        detailsView.addToListDelegate = self
        switch flux {
        case .home:
            homeNavigation?.pushViewController(detailsView, animated: true)
        case .search:
            searchNavigation?.pushViewController(detailsView, animated: true)
        case .profile:
            profileNavigation?.pushViewController(detailsView, animated: true)
        case .yourlist:
            profileNavigation?.pushViewController(detailsView, animated: true)
        }
    }
    
    func detailsTelevisionViewController(model: Television, flux: Flux) {
        let viewModel = DetailsTelevisionViewModel(television: model)
        let detailsView = DetailsTelevisionViewController(viewModel: viewModel)
        
        switch flux {
        case .home:
            homeNavigation?.pushViewController(detailsView, animated: true)
        case .search:
            searchNavigation?.pushViewController(detailsView, animated: true)
        case .profile:
            profileNavigation?.pushViewController(detailsView, animated: true)
        case .yourlist:
            profileNavigation?.pushViewController(detailsView, animated: true)
        }
    }
    
    func detailsListViewController(model: List) {
        let viewModel = YourlistViewModel(list: model)
        let detailsList = YourlistViewController(viewModel: viewModel)
        detailsList.didSelectDelegate = self
        profileNavigation?.pushViewController(detailsList, animated: true)
    }
    
    func createListViewController() {
        let viewModel = CreateNewListViewModel()
        let createListView = CreateNewListViewController(viewModel: viewModel)
        createListView.didCreateDelegate = self
        profileNavigation?.present(createListView, animated: true)
    }
    
    func addItemToListViewController(model: Movies) {
        let viewModel = AddItemListViewModel(movies: model)
        let addItemToList = AddItemListViewController(viewModel: viewModel)
        addItemToList.didAddToListDelegate = self
        homeNavigation?.present(addItemToList, animated: true)
    }
    
}

extension AppCoordinator: DetailsSelectDelegate {
    
    func listSelected(list: List) {
        detailsListViewController(model: list)
    }
    
    func televisonSelected(televison: Television, flux: Flux) {
        detailsTelevisionViewController(model: televison, flux: flux)
    }
    
    func movieSelected(movie: Movies, flux: Flux) {
        detailsMovieViewController(model: movie, flux: flux)
    }
    
}

extension AppCoordinator: LoginCoordinatorDelegate {
    
    func didLogin() {
        start()
    }
    
}

extension AppCoordinator: CreateListDelegate {
    
    func didCreateList() {
        createListViewController()
    }
    
}

extension AppCoordinator: AddItemToListDelegate {
    
    func addItemToSelectedList(movie: Movies) {
        addItemToListViewController(model: movie)
    }
    
}
