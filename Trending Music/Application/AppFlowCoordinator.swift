//
//  AppFlowCoordinator.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let albumsSceneDIContainer = appDIContainer.makeAlbumsSceneDIContainer()
        let flow = albumsSceneDIContainer.makeAlbumsListFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
