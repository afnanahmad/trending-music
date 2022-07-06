//
//  AlbumListFlowCoordinator.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import UIKit

protocol AlbumListFlowCoordinatorDependencies {
    func makeAlbumListViewController(actions: AlbumListViewModelActions) -> AlbumListView
    func makeAlbumDetailViewController(album: Album, actions: AlbumDetailViewModelActions) -> AlbumDetailView
}

final class AlbumListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: AlbumListFlowCoordinatorDependencies

    private weak var albumListVC: AlbumListView?

    init(navigationController: UINavigationController,
         dependencies: AlbumListFlowCoordinatorDependencies)
    {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = AlbumListViewModelActions(showAlbumDetails: showAlbumDetails)

        let vc = dependencies.makeAlbumListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        albumListVC = vc
    }

    private func showAlbumDetails(album: Album) {
        let actions = AlbumDetailViewModelActions(visit: visitAlbum, dimiss: dismissAlbumDetailView)

        let vc = dependencies.makeAlbumDetailViewController(album: album, actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func visitAlbum(album: Album) {
        if let albumUrl = album.url, let url = URL(string: albumUrl) {
            UIApplication.shared.open(url)
        }
    }

    private func dismissAlbumDetailView() {
        navigationController?.popViewController(animated: true)
    }
}
