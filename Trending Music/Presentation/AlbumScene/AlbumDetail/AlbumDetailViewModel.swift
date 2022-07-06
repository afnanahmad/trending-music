//
//  AlbumDetailViewModel.swift
//  Trending Music
//
//  Created Afnan Ahmad on 2022-07-05.
//

import Foundation

struct AlbumDetailViewModelActions {
    let visit: (Album) -> Void
    let dimiss: () -> Void
}

protocol AlbumDetailViewModelProtocol {
    func finishViewDidLoad()
    func didReceiveUISelect(object: Album)
    func didReceiveUIVisit(album: Album)
}

class AlbumDetailViewModel {
    var view: AlbumDetailViewProtocol!
    let album: Album
    let actions: AlbumDetailViewModelActions!

    init(album: Album, actions: AlbumDetailViewModelActions) {
        self.album = album
        self.actions = actions
    }
}

extension AlbumDetailViewModel: AlbumDetailViewModelProtocol {
    func finishViewDidLoad() {
        view.viewWillPresent(data: album)
    }

    func didReceiveUISelect(object: Album) {}

    func didReceiveUIVisit(album: Album) {
        actions?.visit(album)
    }

    func didReceiveUIDismiss() {
        actions?.dimiss()
    }
}
