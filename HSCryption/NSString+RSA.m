#import "NSString+RSA.h"
#import <Security/Security.h>
#import "NSData+Base64.h"

@implementation NSString (RSA)

- (NSString *)RSAEncodingWithCertPath:(NSString *)certPath {
    SecKeyRef publicKey = nil;
    publicKey = [self getPublicKey:certPath];
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = NULL;
    
    cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0*0, cipherBufferSize);
    
    NSData *plainTextBytes = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger blockSize = cipherBufferSize - 11;  // 这个地方比较重要是加密问组长度
    int numBlock = (int)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init];
    for (int i = 0; i < numBlock; i ++) {
        NSUInteger bufferSize = MIN(blockSize, [plainTextBytes length] - i * blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(publicKey,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        if (status == noErr) {
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }
        else {
            return nil;
        }
    }
    if (cipherBuffer) {
        free(cipherBuffer);
    }
    NSString *encrypotoResult = [NSString stringWithFormat:@"%@",[encryptedData base64EncodedString]];
    
    return encrypotoResult;
}

- (SecKeyRef)getPublicKey:(NSString *)certPath {
    SecCertificateRef myCertificate = nil;
    NSData *certificateData = [[NSData alloc] initWithContentsOfFile:certPath];
    myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (CFDataRef)certificateData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    return SecTrustCopyPublicKey(myTrust);
}

@end
