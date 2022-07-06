//
//  UILabel+Kerning.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-05.
//

import UIKit

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 1) {
        if let labelText = text, labelText.isEmpty == false {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.kern,
                                          value: kernValue,
                                          range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
