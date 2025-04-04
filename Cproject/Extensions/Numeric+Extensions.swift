//
//  Numeric+Extensions.swift
//  Cproject
//
//  Created by wodnd on 4/5/25.
//

import Foundation

extension Numeric {
    var moneyString: String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return (formatter.string(for: self) ?? "") + "원"
    }
}
