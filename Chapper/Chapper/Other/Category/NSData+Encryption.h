//
//  NSData+Encryption.h
//  OneYuanBuy
//
//  Created by design on 16/8/24.
//  Copyright © 2016年 lixin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)

- (NSData *)AES256EncryptWithKey:(NSData *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSData *)key;   //解密
- (NSString *)newStringInBase64FromData;            //追加64编码
+ (NSString*)base64encode:(NSString*)str;           //同上64编码
@end