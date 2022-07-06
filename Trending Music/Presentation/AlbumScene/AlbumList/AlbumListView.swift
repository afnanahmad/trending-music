//
//  AlbumListView.swift
//  Trending Music
//
//  Created Afnan Ahmad on 2022-07-04.
//

import UIKit

protocol AlbumListViewProtocol {
    func viewWillPresent(data: [Album])
    func showLoading()
    func hideLoading()
    func show(error: Error)
}

class AlbumListView: UIViewController, AlbumListViewProtocol {
    private var ui = AlbumListUI()
    var viewModel: AlbumListViewModel! {
        willSet {
            newValue.view = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchData()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("Top 100 Albums", comment: "top albums")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    @objc func playTapped() {}

    override func loadView() {
        ui.delegate = self
        view = ui
    }

    func viewWillPresent(data: [Album]) {
        ui.albums = data
    }

    func showLoading() {
        LoadingView.show()
    }

    func hideLoading() {
        LoadingView.hide()
    }

    func show(error: Error) {
        ui.show(error: error)
    }
}

extension AlbumListView: AlbumListUIDelegate {
    func uiDidSelect(object: Album) {
        viewModel.didReceiveUISelect(object: object)
    }

    func uiDidSelectRetry() {
        viewModel.didReceiveUIRetry()
        ui.hideErrorView()
    }
}
