//
//  UIStackView+Ex.swift
//  Verregular App-Code
//
//  Created by Юлия Дегтярева on 2025-04-21.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
