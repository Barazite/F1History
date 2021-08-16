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
    
    func toDateFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let date = dateFormatter.date(from: self) else {
              return self
        }
        return "\(date)"
    }
}
