#import <Foundation/Foundation.h>

@interface NSString (TripleDES)

// 加密算法,请保证密钥长度是8,否则后果自负
- (NSString *)tripleDESEncodingWithKey1:(NSString *)key1 key2:(NSString *)key2 key3:(NSString *)key3;
- (NSString *)tripleDESDecodingWithKey1:(NSString *)key1 key2:(NSString *)key2 key3:(NSString *)key3;

@end
