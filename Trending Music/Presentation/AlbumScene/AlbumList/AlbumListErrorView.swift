//
//  AlbumListErrorView.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-05.
//

import UIKit

class AlbumListErrorView: UIView {
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 181, green: 181, blue: 181)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
        
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.addCharacterSpacing(kernValue: AppAppearance.defaultLetterSpacing)
        button.setImage(UIImage(named: "refresh")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        
        button.backgroundColor = .init(red: 0, green: 122, blue: 255)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
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

extension AlbumListErrorView {
    private func setupUIElements() {
        // arrange subviews
        addSubview(errorLabel)
        addSubview(retryButton)
        
        backgroundColor = .white
        
        errorLabel.text = "No internet connection"
        setupConstraints()
    }
    
    private func setupConstraints() {
        // add constraints to subviews
        
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 8),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

extension AlbumListErrorView {
    func showError(_ text: String) {
        errorLabel.text = text
    }
}
