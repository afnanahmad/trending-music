//
//  AlbumListViewModel.swift
//  Trending Music
//
//  Created Afnan Ahmad on 2022-07-04.
//

import Foundation

struct AlbumListViewModelActions {
    let showAlbumDetails: (Album) -> Void
}

protocol AlbumListViewModelProtocol {
    func fetchData()
    func didReceiveUISelect(object: Album)
    func didReceiveUIRetry()
}

class AlbumListViewModel {
    var view: AlbumListViewProtocol!
    var repository: AlbumRepository!
    private let actions: AlbumListViewModelActions?

    init(actions: AlbumListViewModelActions) {
        self.actions = actions
    }

    func fetchData() {
        repository.fetchAlbumList { [weak self] albums in
            if albums.count > 0 {
                self?.view.viewWillPresent(data: albums)
            } else {
                self?.view.showLoading()
            }
        } completion: { [weak self] result in
            switch result {
            case .success(let albums):
                self?.view.viewWillPresent(data: albums)
                self?.view.hideLoading()
            case .failure(let error):
                self?.view.hideLoading()
                self?.view.show(error: error)
            }
        }
    }

    func didReceiveUISelect(object: Album) {
        actions?.showAlbumDetails(object)
    }

    func didReceiveUIRetry() {
        fetchData()
    }
}
