//
//  TMNavigationController.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-06.
//

import UIKit

class TMNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    override func loadView() {
        super.loadView()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension TMNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
