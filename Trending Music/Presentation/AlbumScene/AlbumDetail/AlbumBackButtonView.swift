//
//  AlbumBackButtonView.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-05.
//

import UIKit

class AlbumBackButtonItem: UIBarButtonItem {
    private var actionHandler: (() -> Void)?
    
    convenience init(actionHandler: (() -> Void)?) {
        let buttonWidth: CGFloat = 32.0
        let customView = AlbumBackButtonView(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonWidth))
        
        self.init(customView: customView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        tap.cancelsTouchesInView = false
        customView.addGestureRecognizer(tap)
        
        self.actionHandler = actionHandler
    }
    
    @objc private func backButtonTapped() {
        actionHandler?()
    }
}

class AlbumBackButtonView: UIView {
    var action: (() -> Void)?
    
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back-arrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        return imageView
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.layer.cornerRadius = frame.width / 2
        blurView.layer.masksToBounds = true
    }
}

extension AlbumBackButtonView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            backImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            backImageView.heightAnchor.constraint(equalTo: backImageView.widthAnchor),
        ])
    }
    
    func setupUIElements() {
        addSubview(blurView)
        addSubview(backImageView)
    }
}
