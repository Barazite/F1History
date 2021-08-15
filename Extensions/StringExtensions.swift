//
//  StringExtensions.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 14/8/21.
//

import Foundation

extension String{
    public var localized: String{
        return NSLocalizedString(self, comment: "")
    }
}
