//
//  AppDIContainer.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import Foundation

final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()

    // MARK: - DIContainers of scenes

    func makeAlbumsSceneDIContainer() -> AlbumsSceneDIContainer {
        let dependencies = AlbumsSceneDIContainer.Dependencies()
        return AlbumsSceneDIContainer(dependencies: dependencies)
    }
}
