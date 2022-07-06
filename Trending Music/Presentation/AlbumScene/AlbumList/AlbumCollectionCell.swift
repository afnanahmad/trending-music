//
//  AlbumCollectionCell.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-05.
//

import UIKit

// MARK: - Album Collection Cell

class AlbumCollectionCell: UICollectionViewCell {
    // Constants
    private let cornerRadius = 16.0
    private let spacing = 12.0
    
    private let albumTitleLabelFontSize = 16.0
    private let ablumArtistLabeltFontSize = 12.0
    
    private let labelMaxLines = 2
    private let albumImageWidth = 200
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // creating gradient for album cover
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 0.5), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        imageView.layer.insertSublayer(gradientLayer, at: 0)
        
        return imageView
    }()
    
    lazy var albumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.textColor = .white
        label.numberOfLines = labelMaxLines
        label.font = UIFont.systemFont(ofSize: albumTitleLabelFontSize, weight: .bold)
        
        return label
    }()
    
    lazy var albumArtistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.textColor = .init(red: 181, green: 181, blue: 181)
        label.numberOfLines = labelMaxLines
        label.font = UIFont.systemFont(ofSize: ablumArtistLabeltFontSize, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(roundedView)
        roundedView.addSubview(albumImageView)
        roundedView.addSubview(albumTitleLabel)
        roundedView.addSubview(albumArtistLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: topAnchor),
            roundedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: roundedView.topAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            albumArtistLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -spacing),
            albumArtistLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: spacing),
            albumArtistLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -spacing),
        ])
        
        NSLayoutConstraint.activate([
            albumTitleLabel.bottomAnchor.constraint(equalTo: albumArtistLabel.topAnchor),
            albumTitleLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: spacing),
            albumTitleLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -spacing),
        ])
    }
    
    func updateView(album: Album) {
        albumTitleLabel.text = album.name
        albumTitleLabel.addCharacterSpacing(kernValue: AppAppearance.defaultLetterSpacing)
        albumArtistLabel.text = album.artistName ?? "N/A"
        albumImageView.image = nil
        if let artworkUrl = album.artworkUrl100 {
            guard let url = NSURL(string: artworkUrl) else { return }
            
            let baseImageUrl = url.deletingLastPathComponent
            let highResImageUrl = baseImageUrl?.appendingPathComponent("\(albumImageWidth)x\(albumImageWidth)bb.jpg")
            
            albumImageView.downloadImage(with: highResImageUrl!.absoluteString, contentMode: UIView.ContentMode.scaleAspectFit)
        }
    }
}
