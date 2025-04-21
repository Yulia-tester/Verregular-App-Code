//
//  UIView+EX.swift
//  Verregular App-Code
//
//  Created by Юлия Дегтярева on 2025-04-21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
