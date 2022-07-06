//
//  AlbumDetailUI.swift
//  Trending Music
//
//  Created Afnan Ahmad on 2022-07-05.
//

import UIKit

protocol AlbumDetailUIDelegate {
    func uiDidSelect(object: Album)
    func uiDidSelectVisit(album: Album)
}

class AlbumDetailUI: UIView {
    // UI constants
    private let horizontalSpacing = 16.0
    private let verticalSpacing = 12.0
    private let bottomSpacing = 47.0
    private let copyRightTextBottomSpacing = 24.0
    
    private let albumImageWidth = 1000
    
    private let artistNameLetterSpacing = -1.36
    private let albumTitleLetterSpacing = -0.72
    
    private let maxLabelLines = 2
    
    private let visitTheAlbumButtonWidth = 155.0
    private let visitTheAlbumButtonHeight = 45.0
    
    var delegate: AlbumDetailUIDelegate!
    
    var object: Album? {
        didSet {
            updateUI()
        }
    }
    
    lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        
        // creating gradient for album cover
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.75).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 0.5), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        imageView.layer.insertSublayer(gradientLayer, at: 0)
        
        return imageView
    }()
    
    private let albumTitleLabelFontSize = 34.0
    lazy var albumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.textColor = .init(red: 17, green: 18, blue: 38)
        label.numberOfLines = maxLabelLines
        label.font = UIFont.systemFont(ofSize: albumTitleLabelFontSize, weight: .bold)
        
        return label
    }()
    
    private let albumArtistLabelFontSize = 18.0
    lazy var albumArtistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.textColor = .init(red: 142, green: 142, blue: 147)
        label.numberOfLines = maxLabelLines
        label.font = UIFont.systemFont(ofSize: albumArtistLabelFontSize, weight: .regular)
        
        return label
    }()
    
    lazy var albumTagsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = 8
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let visitAlbumButtonFontSize = 16.0
    lazy var visitAlbumButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Visit The Album", comment: "Visit The Album"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: visitAlbumButtonFontSize, weight: .semibold)
        button.titleLabel?.addCharacterSpacing(kernValue: AppAppearance.defaultLetterSpacing)
        
        button.backgroundColor = .init(red: 0, green: 122, blue: 255)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private let albumCopyRightLabelFontSize = 12.0
    lazy var albumCopyRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 181, green: 181, blue: 181)
        label.font = .systemFont(ofSize: albumCopyRightLabelFontSize, weight: .medium)
        label.textAlignment = .center
        
        return label
        
    }()
    
    private let albumReleaseDateLabelFontSize = 12.0
    lazy var albumReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 181, green: 181, blue: 181)
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        
        return label
        
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

extension AlbumDetailUI {
    private func setupUIElements() {
        // arrange subviews
        backgroundColor = .white
        addSubview(albumImageView)
        
        addSubview(albumArtistLabel)
        addSubview(albumTitleLabel)
        addSubview(albumTagsStackView)
        
        addSubview(visitAlbumButton)
        addSubview(albumCopyRightLabel)
        addSubview(albumReleaseDateLabel)
        
        visitAlbumButton.addTarget(self, action: #selector(visitTheAlbumTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        // add constraints to subviews
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: topAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            albumArtistLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: verticalSpacing),
            albumArtistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalSpacing),
            albumArtistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalSpacing),
        ])
        
        NSLayoutConstraint.activate([
            albumTitleLabel.topAnchor.constraint(equalTo: albumArtistLabel.bottomAnchor),
            albumTitleLabel.leadingAnchor.constraint(equalTo: albumArtistLabel.leadingAnchor),
            albumTitleLabel.trailingAnchor.constraint(equalTo: albumArtistLabel.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            albumTagsStackView.topAnchor.constraint(equalTo: albumTitleLabel.bottomAnchor),
            albumTagsStackView.leadingAnchor.constraint(equalTo: albumArtistLabel.leadingAnchor),
            albumTagsStackView.trailingAnchor.constraint(equalTo: albumTitleLabel.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            visitAlbumButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomSpacing),
            visitAlbumButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            visitAlbumButton.widthAnchor.constraint(equalToConstant: visitTheAlbumButtonWidth),
            visitAlbumButton.heightAnchor.constraint(equalToConstant: visitTheAlbumButtonHeight),
        ])
        
        NSLayoutConstraint.activate([
            albumCopyRightLabel.bottomAnchor.constraint(equalTo: visitAlbumButton.topAnchor, constant: -copyRightTextBottomSpacing),
            albumCopyRightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalSpacing),
            albumCopyRightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalSpacing),
        ])
        
        NSLayoutConstraint.activate([
            albumReleaseDateLabel.bottomAnchor.constraint(equalTo: albumCopyRightLabel.topAnchor),
            albumReleaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalSpacing),
            albumReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalSpacing),
        ])
    }
    
    private func updateUI() {
        albumArtistLabel.text = object?.artistName
        albumArtistLabel.addCharacterSpacing(kernValue: artistNameLetterSpacing)
        albumTitleLabel.text = object?.name
        albumTitleLabel.addCharacterSpacing(kernValue: albumTitleLetterSpacing)
        albumCopyRightLabel.text = NSLocalizedString("Copyright 2022 Apple Inc. All rights reserved.", comment: "Copyright 2022 Apple Inc. All rights reserved.")
        if let releaseDateString = object?.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let releaseDate = dateFormatter.date(from: releaseDateString) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                
                albumReleaseDateLabel.text = "Released \(dateFormatter.string(from: releaseDate))"
            }
        }
        
        if let genres = object?.genres {
            if let genre = genres.first {
                let tagView = AlbumGenreLabelView()
                tagView.translatesAutoresizingMaskIntoConstraints = false
                tagView.albumTagLabel.text = genre.name
                tagView.albumTagLabel.addCharacterSpacing(kernValue: AppAppearance.defaultLetterSpacing)
                albumTagsStackView.addArrangedSubview(tagView)
            }
        }
        
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        albumTagsStackView.addArrangedSubview(spacerView)

        albumImageView.image = nil
        
        if let artworkUrl = object?.artworkUrl100 {
            guard let url = NSURL(string: artworkUrl) else { return }
            
            // hack to get higher resolution artwork images
            let baseImageUrl = url.deletingLastPathComponent
            if let highResImageUrl = baseImageUrl?.appendingPathComponent("\(albumImageWidth)x\(albumImageWidth)bb.jpg") {
                albumImageView.downloadImage(with: highResImageUrl.absoluteString, contentMode: UIView.ContentMode.scaleAspectFit)
            }
        }
    }
    
    @objc private func visitTheAlbumTapped() {
        if let album = object {
            delegate?.uiDidSelectVisit(album: album)
        }
    }
}

class AlbumGenreLabelView: UIView {
    private let spacing = 4.0
    
    private let color = UIColor(red: 0, green: 122, blue: 255)
    
    lazy var albumTagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.textColor = color
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUIElements()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}

extension AlbumGenreLabelView {
    func setupUIElements() {
        layer.borderColor = color.cgColor
        layer.borderWidth = 1.0
        
        addSubview(albumTagLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            albumTagLabel.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            albumTagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
            albumTagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing * 2),
            albumTagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing * 2),
        ])
    }
}
