//
//  String+SKAdditions.swift
//  SwiftiumKit
//
//  Created by Richard Bergoin on 10/03/16.
//  Copyright © 2016 Openium. All rights reserved.
//

import Foundation

// MARK: Hashes

private typealias SKCryptoFunctionPointer = (UnsafePointer<Void>, UInt32, UnsafePointer<Void>) -> Void

private enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var cryptoFunction: SKCryptoFunctionPointer {
        var result: SKCryptoFunctionPointer
        switch self {
        case .MD5: result = sk_crypto_md5
        case .SHA1: result = sk_crypto_sha1
        case .SHA224: result = sk_crypto_sha224
        case .SHA256: result = sk_crypto_sha256
        case .SHA384: result = sk_crypto_sha384
        case .SHA512: result = sk_crypto_sha512
        }
        return result
    }
    
    var digestLength: Int {
        var length: Int
        switch self {
        case .MD5: length = Int(SK_MD5_DIGEST_LENGTH)
        case .SHA1: length = Int(SK_SHA1_DIGEST_LENGTH)
        case .SHA224: length = Int(SK_SHA224_DIGEST_LENGTH)
        case .SHA256: length = Int(SK_SHA256_DIGEST_LENGTH)
        case .SHA384: length = Int(SK_SHA384_DIGEST_LENGTH)
        case .SHA512: length = Int(SK_SHA512_DIGEST_LENGTH)
        }
        return length
    }
}

extension String.UTF8View {
    
    var md5: NSData {
        return self.hashUsingAlgorithm(.MD5)
    }
    
    var sha1: NSData {
        return self.hashUsingAlgorithm(.SHA1)
    }
    
    var sha224: NSData {
        return self.hashUsingAlgorithm(.SHA224)
    }

    var sha256: NSData {
        return self.hashUsingAlgorithm(.SHA256)
    }

    var sha384: NSData {
        return self.hashUsingAlgorithm(.SHA384)
    }

    var sha512: NSData {
        return self.hashUsingAlgorithm(.SHA512)
    }
    
    private func hashUsingAlgorithm(algorithm: CryptoAlgorithm) -> NSData {
        let cryptoFunction = algorithm.cryptoFunction
        let length = algorithm.digestLength
        return self.hash(cryptoFunction, length: length)
    }
    
    private func hash(cryptoFunction: SKCryptoFunctionPointer, length: Int) -> NSData {
        let hashBytes = UnsafeMutablePointer<UInt8>.alloc(length)
        //defer { hashBytes.dealloc(length) }

        cryptoFunction(Array<UInt8>(self), UInt32(self.count), hashBytes)

        return NSData(bytesNoCopy: hashBytes, length: length)
    }
}

extension String {

    public var md5HashData: NSData {
        return self.utf8.md5
    }
    
    /// Converts string UTF8 data to MD5 checksum (lowercase hexadecimal)
    /// :returns: lowercase hexadecimal string containing MD5 hash
    public var md5: String {
        return self.md5HashData.base16EncodedString()
    }

    public var sha1HashData: NSData {
        return self.utf8.sha1
    }
    
    /// Converts string UTF8 data to SHA1 checksum (lowercase hexadecimal)
    /// :returns: lowercase hexadecimal string containing SHA1 hash
    public var sha1: String {
        return self.sha1HashData.base16EncodedString()
    }
    
    public var sha224HashData: NSData {
        return self.utf8.sha224
    }
    
    /// Converts string UTF8 data to SHA224 checksum (lowercase hexadecimal)
    /// :returns: lowercase hexadecimal string containing SHA224 hash
    public var sha224: String {
        return self.sha224HashData.base16EncodedString()
    }
    
    public var sha256HashData: NSData {
        return self.utf8.sha256
    }
    
    /// Converts string UTF8 data to SHA256 checksum (lowercase hexadecimal)
    /// :returns: lowercase hexadecimal string containing SHA256 hash
    public var sha256: String {
        return self.sha256HashData.base16EncodedString()
    }
    
    public var sha384HashData: NSData {
        return self.utf8.sha384
    }
    
    /// Converts string UTF8 data to SHA384 checksum (lowercase hexadecimal)
    /// :returns: lowercase hexadecimal string containing SHA384 hash
    public var sha384: String {
        return self.sha384HashData.base16EncodedString()
    }
    
    public var sha512HashData: NSData {
        return self.utf8.sha512
    }
    
    /// Converts string UTF8 data to SHA512 checksum (lowercase hexadecimal)
    /// :returns: lowercase hexadecimal string containing SHA512 hash
    public var sha512: String {
        return self.sha512HashData.base16EncodedString()
    }
    
    
    public func hmacSha1(key: String) -> String {
        let keyData = Array<UInt8>(key.utf8)
        let length = Int(20)
        
        let hashBytes = UnsafeMutablePointer<UInt8>.alloc(length)
        //defer { hashBytes.dealloc(length) }
        
        sk_crypto_hmac_sha1(Array<UInt8>(self.utf8), UInt32(self.utf8.count), keyData, UInt32(key.utf8.count), hashBytes)
        let data = NSData(bytesNoCopy: hashBytes, length: length)
        
        return data.base16EncodedString()
    }
    
}
