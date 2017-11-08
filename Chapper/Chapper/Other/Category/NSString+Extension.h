
//  Weibo
//
//  Created by Fay on 15/10/3.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
-(NSString *) sha1;
-(NSString *) sha224;
-(NSString *) sha256;
-(NSString *) sha384;
-(NSString *) sha512;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com