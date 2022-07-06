//
//  AlbumDetailView.swift
//  Trending Music
//
//  Created Afnan Ahmad on 2022-07-05.
//

import UIKit

protocol AlbumDetailViewProtocol {
    func viewWillPresent(data: Album)
}

class AlbumDetailView: UIViewController, AlbumDetailViewProtocol {
    private var ui = AlbumDetailUI()
    var viewModel: AlbumDetailViewModel! {
        willSet {
            newValue.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.finishViewDidLoad()
    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override func loadView() {
        super.loadView()
        ui.delegate = self
        view = ui

        let backButton = AlbumBackButtonItem { [weak self] in
            self?.viewModel.didReceiveUIDismiss()
        }
        navigationItem.leftBarButtonItem = backButton
    }

    func viewWillPresent(data: Album) {
        ui.object = data
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension AlbumDetailView: AlbumDetailUIDelegate {
    func uiDidSelect(object: Album) {
        viewModel.didReceiveUISelect(object: object)
    }

    func uiDidSelectVisit(album: Album) {
        viewModel.didReceiveUIVisit(album: album)
    }
}
