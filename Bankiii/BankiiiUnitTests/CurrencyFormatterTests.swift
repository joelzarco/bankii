//
//  CurrencyFormatterTests.swift
//  BankiiiUnitTests
//
//  Created by Johel Zarco on 01/05/22.
//

import Foundation
import XCTest

@testable import Bankiii

class Test : XCTestCase{
    // class to test
    var formatter : CurrencyFormatter!
    // called independently every test, clean
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
        
    }
    
    func testBreakDollarsAndCents() throws{
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws{
        // sholud convert 929466 > "$929,466.00"
        let res = formatter.dollarsFormatted(999666.11)
        XCTAssertEqual(res, "$999,666.11")
    }
    
    func testZeroDollarsFormatted()throws{
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
    }
}
