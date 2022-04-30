//
//  DecimalUtils.swift
//  Bankiii
//
//  Created by Johel Zarco on 30/04/22.
//

import Foundation

extension Decimal{
    var doubleValue : Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
