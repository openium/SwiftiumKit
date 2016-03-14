//
//  Crypto.h
//  SwiftiumKit
//
//  Created by Richard Bergoin on 10/03/16.
//  Copyright © 2016 Openium. All rights reserved.
//

extern const int SK_MD5_DIGEST_LENGTH;
extern const int SK_SHA1_DIGEST_LENGTH;
extern const int SK_SHA224_DIGEST_LENGTH;
extern const int SK_SHA256_DIGEST_LENGTH;
extern const int SK_SHA384_DIGEST_LENGTH;
extern const int SK_SHA512_DIGEST_LENGTH;

void sk_crypto_md5(const void *data, unsigned int len, const void *output);
void sk_crypto_sha1(const void *data, unsigned int len, const void *output);
void sk_crypto_sha256(const void *data, unsigned int len, const void *output);
void sk_crypto_sha384(const void *data, unsigned int len, const void *output);
void sk_crypto_sha224(const void *data, unsigned int len, const void *output);
void sk_crypto_sha512(const void *data, unsigned int len, const void *output);

void sk_crypto_hmac_sha1(const void *data, unsigned int dataLength, const void *key, unsigned int keyLength, void *output);

unsigned char *sk_crypto_encrypt_aes256(const void *data, unsigned int dataLength, const void *key, unsigned int keyLength, unsigned long *numBytesWritten);
unsigned char *sk_crypto_decrypt_aes256(const void *data, unsigned int dataLength, const void *key, unsigned int keyLength, unsigned long *numBytesWritten);
unsigned char *sk_crypto_encrypt_aes192(const void *data, unsigned int dataLength, const void *key, unsigned int keyLength, unsigned long *numBytesWritten);
unsigned char *sk_crypto_decrypt_aes192(const void *data, unsigned int dataLength, const void *key, unsigned int keyLength, unsigned long *numBytesWritten);
unsigned char *sk_crypto_encrypt_aes128(const void *data, unsigned int dataLength, const void *key, unsigned int keyLength, unsigned long *numBytesWritten);
unsigned char *sk_crypto_decrypt_aes128(const void *data, unsigned int dataLength, const void *key, unsigned int keyLength, unsigned long *numBytesWritten);
