//
//  NSDataExtensions.swift
//  SwiftiumKit
//
//  Created by Richard Bergoin on 14/03/16.
//  Copyright © 2016 Openium. All rights reserved.
//

import Foundation

// MARK: AES encrypt/decrypt

private typealias SKCryptOperationFunction = (UnsafePointer<Void>, UInt32, UnsafePointer<Void>, UInt32, UnsafeMutablePointer<UInt>) -> UnsafeMutablePointer<UInt8>

private enum EncryptionAlgorithm {
    case AES128, AES192, AES256
    
    var encryptFunction: SKCryptOperationFunction {
        var encryptFunction: SKCryptOperationFunction
        switch self {
        case .AES128: encryptFunction = sk_crypto_encrypt_aes128
        case .AES192: encryptFunction = sk_crypto_encrypt_aes192
        case .AES256: encryptFunction = sk_crypto_encrypt_aes256
        }
        return encryptFunction
    }
    
    var decryptFunction: SKCryptOperationFunction {
        var decryptFunction: SKCryptOperationFunction
        switch self {
        case .AES128: decryptFunction = sk_crypto_decrypt_aes128
        case .AES192: decryptFunction = sk_crypto_decrypt_aes192
        case .AES256: decryptFunction = sk_crypto_decrypt_aes256
        }
        return decryptFunction
    }
}

extension NSData {
    
    public convenience init?(base16EncodedString: String) {
        let dataLen = base16EncodedString.characters.count / 2
        let allocatedBytes = malloc(dataLen)
        let bytes = UnsafeMutablePointer<UInt8>(allocatedBytes)
        
        let charactersAsUInt8 = base16EncodedString.characters.map {
            UInt8( strtoul((String($0)), nil, 16))
        }
        
        var strIdx = 0
        for idx in 0..<dataLen {
            let c1 = charactersAsUInt8[strIdx]
            let c2 = charactersAsUInt8[strIdx + 1]
            //bytes[idx]
            bytes[idx] = UInt8((c1<<4) + c2)
            strIdx += 2
        }
        self.init(bytesNoCopy: bytes, length: dataLen)
    }
    
    public convenience init?(bytesArray: Array<UInt8>) {
        let dataLen = bytesArray.count
        let allocatedBytes = malloc(dataLen)
        let bytes = UnsafeMutablePointer<UInt8>(allocatedBytes)
        
        var idx = 0
        for byte in bytesArray {
            bytes[idx] = byte
            idx += 1
        }
        self.init(bytesNoCopy: bytes, length: dataLen)
    }
    
    public func base16EncodedString() -> String {
        var hex = String()
        let bytes = UnsafePointer<UInt8>(self.bytes)
        for idx in 0..<self.length {
            let value: UInt8 = UnsafePointer<UInt8>(bytes)[idx]
            hex.appendContentsOf(value.toHexaString())
        }
        return hex
    }
    
    private func aesOperation(key: String, operation: SKCryptOperationFunction) -> NSData? {
        let lengthPtr = UnsafeMutablePointer<UInt>.alloc(1)
        defer { lengthPtr.dealloc(1) }
        
        let buffer = operation(self.bytes, UInt32(self.length), Array<UInt8>(key.utf8), UInt32(key.utf8.count), lengthPtr)
        let length: Int = Int(lengthPtr[0])
        if( buffer != nil ) {
            return NSData(bytesNoCopy: buffer, length: length)
        }
        return nil
    }
    
    /// Encrypts an Array\<AESEncryptable> using provided `key` (utf8 data) with AES256
    /// :returns: Bytes array of encrypted data
    public func aes256Encrypt(key: String) -> NSData? {
        return aesOperation(key, operation: EncryptionAlgorithm.AES256.encryptFunction)
    }
    
    /// Decrypts an Array\<AESEncryptable> using provided `key` (utf8 data) with AES256
    /// :returns: Bytes array of decrypted data
    public func aes256Decrypt(key: String) -> NSData? {
        return aesOperation(key, operation: EncryptionAlgorithm.AES256.decryptFunction)
    }
    
    /// Encrypts an Array\<AESEncryptable> using provided `key` (utf8 data) with AES192
    /// :returns: Bytes array of encrypted data
    public func aes192Encrypt(key: String) -> NSData? {
        return aesOperation(key, operation: EncryptionAlgorithm.AES192.encryptFunction)
    }
    
    /// Decrypts an Array\<AESEncryptable> using provided `key` (utf8 data) with AES192
    /// :returns: Bytes array of decrypted data
    public func aes192Decrypt(key: String) -> NSData? {
        return aesOperation(key, operation: EncryptionAlgorithm.AES192.decryptFunction)
    }
    
    /// Encrypts an Array\<AESEncryptable> using provided `key` (utf8 data) with AES128
    /// :returns: Bytes array of encrypted data
    public func aes128Encrypt(key: String) -> NSData? {
        return aesOperation(key, operation: EncryptionAlgorithm.AES128.encryptFunction)
    }
    
    /// Decrypts an Array\<AESEncryptable> using provided `key` (utf8 data) with AES128
    /// :returns: Bytes array of decrypted data
    public func aes128Decrypt(key: String) -> NSData? {
        return aesOperation(key, operation: EncryptionAlgorithm.AES128.decryptFunction)
    }
}
