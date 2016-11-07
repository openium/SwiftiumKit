//
//  String+SKAdditionsTests.swift
//  SwiftiumKit
//
//  Created by Richard Bergoin on 10/03/16.
//  Copyright © 2016 Openium. All rights reserved.
//

import XCTest

class StringExtensionsTests: XCTestCase {
    
    let stringToHash = "La chaine à hacher"
    let emptyString = ""
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testMd5() {
        // Given
        
        // When
        let hash = stringToHash.md5
        
        // Expect
        XCTAssertEqual(hash, "bbd5d80e828e166774b4c35076e5b1a6")
    }
    
    func testMd5_withEmptyString() {
        // Given
        
        // When
        let hash = emptyString.md5
        
        // Expect
        XCTAssertEqual(hash, "d41d8cd98f00b204e9800998ecf8427e")
    }
    
    func testSha1() {
        // Given
        
        // When
        let hash = stringToHash.sha1
        
        // Expect
        XCTAssertEqual(hash, "5ba4936fca2ab56482b310ddcf57dc8e87b96b54")
    }
    
    func testSha224() {
        // Given
        
        // When
        let hash = stringToHash.sha224
        
        // Expect
        XCTAssertEqual(hash, "c875a5f938279f1eb0461582757bf101337292c5cab5dde31d25a1f5")
    }
    
    func testSha256() {
        // Given
        
        // When
        let hash = stringToHash.sha256
        
        // Expect
        XCTAssertEqual(hash, "10aad976dbc9336d781821f8b1d87eebf1aff367a6c494646ce4ce7b725b66a4")
    }
    
    func testSha384() {
        // Given
        
        // When
        let hash = stringToHash.sha384
        
        // Expect
        XCTAssertEqual(hash, "15bc03d7299d6edd7ed836bd1821cbab5ddb671c59b7ed6c3dd428e42996bebc47d40a594e97182a4e0fcd7beb6ba663")
    }
    
    func testSha512() {
        // Given
        
        // When
        let hash = stringToHash.sha512
        
        // Expect
        XCTAssertEqual(hash, "4afd5988044494e55a91f26208849ce2221cd50e5b3e363c23f96ebc2f64c0679f5c85325cba71ae8d2df3a523795b2aefb2adb95030a4a4ddf519551e13cc8c")
    }
    
    func testHmacSHA1() {
        // Given
        let passmd5 = "5f4dcc3b5aa765d61d8327deb882cf99";
        let strToSign = "GET\n1391863865\nparam=value&param2=value2\n/path/to/api";
    
        // When
        let shaStr = strToSign.hmacSha1(passmd5)
    
        // Expect
        XCTAssertEqual(shaStr, "18835978a0297b5efca1e44d954f4f0c00b2b903")
    }
    
    func testIntSubscript() {
        // Given
        let someString = "5f4dcc3b5aa765d61d8327deb882cf99";
        
        // When
        let thirdChar = someString[3]
        let lastChar = someString[someString.characters.count - 1]
        
        // Expect
        XCTAssertEqual(thirdChar, "d")
        XCTAssertEqual(lastChar, "9")
    }
    
    func testIntSubscript_outOfRange_shouldReturnNil() {
        // Given
        let someString = "5f4dcc3b5aa765d61d8327deb882cf99";
        
        // When
        let outOfRangeChar = someString[someString.characters.count]
        
        // Expect
        XCTAssertEqual(outOfRangeChar, nil)
    }
    
    func testClosedRangeIntSubscript() {
        // Given
        let someString = "5f4dcc3b5aa765d61d8327deb882cf99";
        
        // When
        let first4Chars = someString[0...3]
        
        // Expect
        XCTAssertEqual(first4Chars, "5f4d")
    }
    
    func testClosedRangeIntSubscript_outOfRange_shouldBounds() {
        // Given
        let someString = "5f4dcc3b5aa765d61d8327deb882cf99";
        
        // When
        let index = someString.characters.count - 4
        let last4Chars = someString[index...Int.max]
        
        // Expect
        XCTAssertEqual(last4Chars, "cf99")
    }
}
