//
//  AlbumListUI.swift
//  Trending Music
//
//  Created Afnan Ahmad on 2022-07-04.
//

import Foundation
import UIKit

protocol AlbumListUIDelegate {
    func uiDidSelect(object: Album)
    func uiDidSelectRetry()
}

class AlbumListUI: UIView {
    var delegate: AlbumListUIDelegate!
    
    var albums: [Album]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.hideErrorView()
                self?.collectionView.performBatchUpdates({
                    let indexSet = IndexSet(integersIn: 0 ... 0)
                    self?.collectionView.reloadSections(indexSet)
                }, completion: nil)
            }
        }
    }

    var cellIdentifier = "AlbumListCellId"
    
    private let spacing = 16.0
    private let numberOfItemsPerRow = 2.0
    private let spacingBetweenCells = 12.0
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewLayout)
        cv.register(AlbumCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    lazy var errorView: AlbumListErrorView = {
        let view = AlbumListErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupConstraints()
    }
}

extension AlbumListUI {
    private func setupUIElements() {
        // arrange subviews
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(errorView)
        errorView.isHidden = true
    }
    
    private func setupConstraints() {
        // add constraints to subviews
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        errorView.retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
    }
}

extension AlbumListUI: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let albums = albums else {
            return
        }
        
        let album = albums[indexPath.row]
        delegate?.uiDidSelect(object: album)
    }
}

extension AlbumListUI: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let albums = albums else {
            return 0
        }
        
        return albums.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? AlbumCollectionCell, let albums = albums else {
            return UICollectionViewCell()
        }
        
        cell.updateView(album: albums[indexPath.row])
        
        return cell
    }
}

extension AlbumListUI: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) // Amount of total spacing in a row
                
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }
}

extension AlbumListUI {
    @objc func retryTapped() {
        delegate?.uiDidSelectRetry()
    }
    
    func show(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = true
            self?.errorView.isHidden = false
            self?.errorView.showError(error.localizedDescription)
        }
    }
    
    func hideErrorView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = false
            self?.errorView.isHidden = true
        }
    }
}
