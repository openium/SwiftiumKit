//
//  UIColor+OSKAdditionsTests.swift
//  OpeniumSwiftKit
//
//  Created by Richard Bergoin on 21/07/15.
//  Copyright (c) 2015 Openium. All rights reserved.
//

import UIKit
import XCTest
import SwiftiumKit

class UIColor_OSKAdditionsTests: XCTestCase {

    let r18:CGFloat = 18.0 / 255.0
    let g18:CGFloat = 18.0 / 255.0
    let b18:CGFloat = 18.0 / 255.0
    let a22:CGFloat = 22.0 / 255.0
    let precision:CGFloat = 0.00001
    
    func testColorFromRGB() {
        // Given
        let rgbValue:Int64 = 0x121212
    
        // When
        let c = UIColor(rgb: rgbValue)
    
        // Expect
        let f = c.cgColor.components
        XCTAssertEqualWithAccuracy(f![0], r18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![1], g18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![2], b18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![3], 1.0, accuracy: precision)
    }

    func testColorFromRGBA_alpha0() {
        // Given
        let rgbValue:Int64 = 0x12121200
    
        // When
        let c = UIColor(rgba: rgbValue)
    
        // Expect
        let f = c.cgColor.components
        XCTAssertEqualWithAccuracy(f![0], r18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![1], g18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![2], b18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![3], 0.0, accuracy: precision)
    }
    
    func testColorFromRGBA() {
        // Given
        let color:Int64 = 0x12121216
    
        // When
        let c = UIColor(rgba: color)
    
        // Expect
        let f = c.cgColor.components
        XCTAssertEqualWithAccuracy(f![0], r18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![1], g18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![2], b18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![3], a22, accuracy: precision)
    }
    
    func testColorFromARGB() {
        // Given
        let color:Int64 = 0x16121212
        
        // When
        let c = UIColor(argb: color)
        
        // Expect
        let f = c.cgColor.components
        XCTAssertEqualWithAccuracy(f![0], r18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![1], g18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![2], b18, accuracy: precision)
        XCTAssertEqualWithAccuracy(f![3], a22, accuracy: precision)
    }
}
