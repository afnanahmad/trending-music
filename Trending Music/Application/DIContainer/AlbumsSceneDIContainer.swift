//
//  AlbumsSceneDIContainer.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import UIKit

final class AlbumsSceneDIContainer {
    struct Dependencies {}

    private let dependencies: Dependencies

    // MARK: - Persistent Storage

    lazy var albumsCache: AlbumsStorage = RealmStorage()

    // MARK: - Init

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Repositories

    func makeAlbumRepository() -> AlbumRepository {
        return DefaultAlbumRepository(cache: albumsCache)
    }

    // MARK: - Flow Coordinators

    func makeAlbumsListFlowCoordinator(navigationController: UINavigationController) -> AlbumListFlowCoordinator {
        return AlbumListFlowCoordinator(navigationController: navigationController,
                                        dependencies: self)
    }
}

extension AlbumsSceneDIContainer: AlbumListFlowCoordinatorDependencies {
    func makeAlbumListViewController(actions: AlbumListViewModelActions) -> AlbumListView {
        let albumListViewModel = AlbumListViewModel(actions: actions)
        let repository = makeAlbumRepository()
        albumListViewModel.repository = repository

        let vc = AlbumListView()
        vc.viewModel = albumListViewModel

        return vc
    }

    func makeAlbumDetailViewController(album: Album, actions: AlbumDetailViewModelActions) -> AlbumDetailView {
        let albumDetailViewModel = AlbumDetailViewModel(album: album, actions: actions)

        let vc = AlbumDetailView()
        vc.viewModel = albumDetailViewModel

        return vc
    }
}
