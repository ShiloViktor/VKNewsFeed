//
//  String + Height.swift
//  VKontakteFeed
//
//  Created by Виктор on 26.03.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        return size.height
    }
}
