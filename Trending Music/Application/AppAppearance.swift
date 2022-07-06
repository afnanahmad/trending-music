//
//  AppAppearance.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import Foundation
import UIKit

final class AppAppearance {
    static let defaultLetterSpacing = -0.64

    static func setupAppearance() {
        let letterSpacing = -0.64
        let titleTextSize = 16.0
        let titleTextFont = UIFont.boldSystemFont(ofSize: titleTextSize)

        let largeTextLetterSpacing = -1.36
        let largeTextSize = 34.0
        let largeTextFont = UIFont.boldSystemFont(ofSize: largeTextSize)

        let titleColor = UIColor(red: 17, green: 18, blue: 38)

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: titleColor,
                                              .kern: letterSpacing,
                                              .font: titleTextFont]
            appearance.largeTitleTextAttributes = [.foregroundColor: titleColor,
                                                   .kern: largeTextLetterSpacing,
                                                   .font: largeTextFont]
            appearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = .white
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,
                                                                .kern: letterSpacing,
                                                                .font: titleTextFont]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,
                                                                     .kern: largeTextLetterSpacing,
                                                                     .font: largeTextFont]
        }
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
