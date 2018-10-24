//
//  NSData+NTK.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//  哈希，加密，解码等功能

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (NTK)

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/// md5 小写
- (NSString *)md5;
/// md2 小写
- (NSString *)md2String;
/// md4 小写
- (NSString *)md4String;
/// md5 小写
- (NSString *)md5String;
/// sha1 小写
- (NSString *)sha1String;
/// sha224 小写
- (NSString *)sha224String;
/// sha256 小写
- (NSString *)sha256String;
/// sha384 小写
- (NSString *)sha384String;
/// sha512 小写
- (NSString *)sha512String;

/// md2 NSData
- (NSData *)md2Data;
/// md4 NSData
- (NSData *)md4Data;
/// md5 NSData
- (NSData *)md5Data;
/// sha1 NSData
- (NSData *)sha1Data;
/// sha224 NSData
- (NSData *)sha224Data;
/// sha256 NSData
- (NSData *)sha256Data;
/// sha384 NSData
- (NSData *)sha384Data;
/// sha512 NSData
- (NSData *)sha512Data;


/// hmac (md5) 小写
- (NSString *)hmacMD5StringWithKey:(NSString *)key;
/// hmac (sha1) 小写
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
/// hmac (sha224) 小写
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;
/// hmac (sha256) 小写
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
/// hmac (sha384) 小写
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;
/// hmac (sha512) 小写

- (NSString *)hmacSHA512StringWithKey:(NSString *)key;
/// hmac (md5) NSData
- (NSData *)hmacMD5DataWithKey:(NSData *)key;
/// hmac (sha1) NSData
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;
/// hmac (sha224) NSData
- (NSData *)hmacSHA224DataWithKey:(NSData *)key;
/// hmac (sha256) NSData
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;
/// hmac (sha384) NSData
- (NSData *)hmacSHA384DataWithKey:(NSData *)key;
/// hmac (sha512) NSData
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;

/// crc32 小写
- (NSString *)crc32String;
/// crc32
- (uint32_t)crc32;

#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/// 从 main bundle 里加载数据 (和 [UIImage imageNamed:] 类似).
- (NSData *)dataNamed:(NSString *)name;

#pragma mark - 加密解密
///=============================================================================
/// @name 加密解密
///=============================================================================

/// aes 加密
/// @param key 加密的key，长度必须是16/24/32 (128/192/256 bits)
/// @param iv  初始向量，长度必须是16 (128 bits), 允许nil。
/// @return 加密成功返回NSData，否则返回nil
- (NSData *)aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;

/// aes 解密
/// @param key 加密的key，长度必须是16/24/32 (128/192/256 bits)
/// @param iv  初始向量，长度必须是16 (128 bits), 允许nil。
/// @return 解密成功返回NSData，否则返回nil
- (NSData *)aes256DecryptWithkey:(NSData *)key iv:(NSData *)iv;

#pragma mark - 编码解码
///=============================================================================
/// @name Encode and decode
///=============================================================================


/// 用 UTF8 解码
- (NSString *)utf8String;

/// 转换为大写 hex 字符串
- (NSString *)hexString;

/// 用 hex 字符串(不区分大小写)创建NSData。 失败则返回nil。
+ (NSData *)dataWithHexString:(NSString *)hexString;

/// 以json方式解码，返回 NSDictionary 或 NSArray。出错则返回nil
- (id)jsonValueDecoded;

#pragma mark - 压缩解压
///=============================================================================
/// @name Inflate and deflate
///=============================================================================

/// 解压 gzip 数据
- (NSData *)gzipInflate;

/// 以 gzip 压缩
- (NSData *)gzipDeflate;

/// 解压 zlib 数据
- (NSData *)zlibInflate;

/// 以 zlib 压缩
- (NSData *)zlibDeflate;

@end

NS_ASSUME_NONNULL_END
