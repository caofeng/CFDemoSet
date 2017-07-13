//
//  CalendarViewController.m
//  DemoSet
//
//  Created by MountainCao on 2017/7/13.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#define kRSAPublicKey @"MIIBpzCCARCgAwIBAgIEV7KGUjANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAzkuK3kuJrlhbTono0wIBcNMTYwODE2MDMyMDAxWhgPMjExNjA4MTYwMzIwMDFaMBcxFTATBgNVBAMMDOS4reS4muWFtOiejTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA8engggbpv4rTBIj3ilENTgLXcT/W2cCWLRRXjMZAGVnSgJdpR1JHee2eYWMfZQzw8k8l3utGAnV6CW08g3iEVHK4yNJFGlHDrBQxSb9w2oyHMXG8qzxz+kK2fdfC6zBctHC71TTH2edc7emgxp0fPqi1F4HkxMNj1OQcjxb9kWcCAwEAATANBgkqhkiG9w0BAQsFAAOBgQCYaOgvty35nTvtKy+UW66FqU2QeO2gRsz5te6hx42Tzmq6b8Tys9hpWGTV3OyRpmRewA650Cn7C0py+E2OEyNZ4GLyxG7NR//ZSDNrAe1Wb+zGOC+3IhOPNY/BD5GSsK87MGwkTsQxxGZysnJTcm1oLgWGxJgj0tnbj6h5tZj9ew=="

#define kRSA_KEY_SIZE 1024

#import "CalendarViewController.h"
#import <Security/Security.h>
#import "NSData+CFHASH.h"
#import "NSData+CFAES.h"
#import "CFSeckeyTools.h"
#import "NSData+CFRSA.h"


@interface CalendarViewController ()
{
    SecKeyRef publicKeyRef; //公钥
    SecKeyRef privateKeyRef;//私钥
}
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    NSLog(@"===%@",NSHomeDirectory());
    
    [self RSAEncryptMethod_3];
  
}

/* 加密方式1：通过cer文件加密 */
- (void)RSAEncryptMethod_1 {
    
     //-----------------------加密
    NSString *password = @"cf1123111551";
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *pubPath = [[NSBundle mainBundle]pathForResource:@"rsa_public_key" ofType:@"der"];
    SecKeyRef pubRef = [CFSeckeyTools publicKeyFromCer:pubPath];
    NSData *encryptData = [data RSAEncryptWith:pubRef paddingType:RSAPaddingNONE];
    NSLog(@"==加密之后的数据=%@",encryptData);
    
    //-----------------------解密
    
    NSString *priPath = [[NSBundle mainBundle]pathForResource:@"rsa_private_key" ofType:@"pem"];
    SecKeyRef priRef = [CFSeckeyTools privaKeyFromPem:priPath keySize:kRSA_KEY_SIZE];
    
    NSData *decryptData = [encryptData RSADecryptWith:priRef paddingType:RSAPaddingNONE];
    NSLog(@"==解密之后的数据=%@",[[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding]);

}

/* 加密方式2：通过pem文件加密:iOS10之后 */
- (void)RSAEncryptMethod_2 {
    
    //----------------------加密
    NSString *password = @"cf1123111551";
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];

    NSString *pubPath = [[NSBundle mainBundle]pathForResource:@"rsa_public_key" ofType:@"pem"];
    SecKeyRef pubRef = [CFSeckeyTools publicKeyFromPem:pubPath keySize:kRSA_KEY_SIZE];
    
    NSData *encryptData = [data RSAEncryptWith:pubRef paddingType:RSAPaddingNONE];
    
    NSLog(@"==加密之后的数据=%@",encryptData);
    
    //-----------------------解密
    
    NSString *priPath = [[NSBundle mainBundle]pathForResource:@"rsa_private_key" ofType:@"pem"];
    SecKeyRef priRef = [CFSeckeyTools privaKeyFromPem:priPath keySize:kRSA_KEY_SIZE];
    
    NSData *decryptData = [encryptData RSADecryptWith:priRef paddingType:RSAPaddingNONE];
    NSLog(@"==解密之后的数据=%@",[[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding]);
    
}

/* 加密方式3：通过PublicKey文件加密 */
- (void)RSAEncryptMethod_3 {
    
    
    NSString *password = @"cf1123111551";
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    //密钥是经过base64加密的
    NSData *rsaKey = [[NSData alloc] initWithBase64EncodedString:kRSAPublicKey
                                                         options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    SecKeyRef publicRef = [self getPublicKeyRefrenceFromeData:rsaKey];
    
    NSData *encryptData = [data RSAEncryptWith:publicRef paddingType:RSAPaddingNONE];
    
    NSLog(@"==加密之后的数据=%@",encryptData);
    
    
////     //-----------------------解密
//    NSString *priPath = [[NSBundle mainBundle]pathForResource:@"rsa_private_key" ofType:@"pem"];
//    SecKeyRef priRef = [CFSeckeyTools privaKeyFromPem:priPath keySize:kRSA_KEY_SIZE];
//    
//    NSData *decryptData = [encryptData RSADecryptWith:priRef paddingType:RSAPaddingNONE];
//    NSLog(@"==解密之后的数据=%@",[[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding]);
    
}


-(SecKeyRef)getPublicKeyRefrenceFromeData:(NSData*)derData
{
    SecCertificateRef myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)derData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr)
    {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    SecKeyRef securityKey = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    return securityKey;
}


/* 系统代码生产公钥密钥对 */

//生成RSA密钥对，公钥和私钥，支持的SIZE有
// sizes for RSA keys are: 512, 768, 1024, 2048.
- (void)generateRSAKeyPair:(int )keySize
{
    
    OSStatus ret = 0;
    publicKeyRef = NULL;
    privateKeyRef = NULL;
    ret = SecKeyGeneratePair((CFDictionaryRef)@{(id)kSecAttrKeyType:(id)kSecAttrKeyTypeRSA,(id)kSecAttrKeySizeInBits:@(keySize)}, &publicKeyRef, &privateKeyRef);
    
    NSAssert(ret==errSecSuccess, @"密钥对生成失败：%d",ret);
    
    NSLog(@"publicKeyRef==%@",publicKeyRef);
    NSLog(@"privateKeyRef==%@",privateKeyRef);
    NSLog(@"max size:%lu",SecKeyGetBlockSize(privateKeyRef));
    
}

//公钥加密私钥解密测试
/** 三种填充方式区别
 kSecPaddingNone      = 0,   要加密的数据块大小<＝SecKeyGetBlockSize的大小，如这里128
 kSecPaddingPKCS1     = 1,   要加密的数据块大小<=128-11
 kSecPaddingOAEP      = 2,   要加密的数据块大小<=128-42
 密码学中的设计原则，一般用RSA来加密 对称密钥，用对称密钥加密大量的数据
 非对称加密速度慢，对称加密速度快
 */
- (void)testRSAEncryptAndDecrypt
{
    [self generateRSAKeyPair:kRSA_KEY_SIZE];
    
    NSString *string = @"波兰当地时间2017年7月7日下午，在波兰克拉科夫举行的第41届世界遗产大会上，青海可可西里经世界遗产委员会一致同意，获准列入《世界遗产名录》，成为中国第51处世界遗产，也是我国面积最大的世界自然遗产地波兰当地时间2017年7月7日下午，在波兰克拉科夫举行的第41届世界遗产大会上，青海可可西里经世界遗产委员会一致同意，获准列入《世界遗产名录》，成为中国第51处世界遗产，也是我国面积最大的世界自然遗产地波兰当地时间2017年7月7日下午，在波兰克拉科夫举行的第41届世界遗产大会上，青海可可西里经世界遗产委员会一致同意，获准列入《世界遗产名录》，成为中国第51处世界遗产，也是我国面积最大的世界自然遗产地波兰当地时间2017年7月7日下午，在波兰克拉科夫举行的第41届世界遗产大会上，青海可可西里经世界遗产委员会一致同意，获准列入《世界遗产名录》，成为中国第51处世界遗产，也是我国面积最大的世界自然遗产地";
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    NSData *srcData = [data hashDataWith:CCDIGEST_MD5];
    
    NSLog(@"%@",srcData);
    
    uint8_t encData[kRSA_KEY_SIZE/8] = {0};
    
    uint8_t decData[kRSA_KEY_SIZE/8] = {0};
    
    size_t blockSize = kRSA_KEY_SIZE / 8 ;
    
    OSStatus ret;
    
    ret = SecKeyEncrypt(publicKeyRef, kSecPaddingNone, srcData.bytes, srcData.length, encData, &blockSize);
    
    NSAssert(ret==errSecSuccess, @"加密失败");
    
    ret = SecKeyDecrypt(privateKeyRef, kSecPaddingNone, encData, blockSize, decData, &blockSize);
    
    NSAssert(ret==errSecSuccess, @"解密失败");
    
    NSData *dedData = [NSData dataWithBytes:decData length:blockSize];
    
    NSLog(@"dec:%@",[dedData hexString]);
    
    if (memcmp(srcData.bytes, dedData.bytes, srcData.length)==0) {
        NSLog(@"PASS");
    }
}

//4. 使用公钥密钥进行数据签名和验证签名

//对数据签名：首先对原始数据进行hash计算，可以得到数据的hash值；然后对hash值进行签名；


- (void)testSignAndVerify
{
    [self generateRSAKeyPair:kRSA_KEY_SIZE];
    
    
    NSString *tpath = [[NSBundle mainBundle] pathForResource:@"src.txt" ofType:nil];
    NSData *ttDt = [NSData dataWithContentsOfFile:tpath];
    
    //使用了下面封装的hash接口
    
    NSData *sha1dg = [ttDt hashDataWith:CCDIGEST_SHA1];
    
    OSStatus ret;
    
    //私钥签名，公钥验证签名
    size_t siglen = SecKeyGetBlockSize(privateKeyRef);
    uint8_t *sig = malloc(siglen);
    bzero(sig, siglen);
    ret = SecKeyRawSign(privateKeyRef, kSecPaddingPKCS1SHA256, sha1dg.bytes, sha1dg.length, sig, &siglen);
    NSAssert(ret==errSecSuccess, @"签名失败");
    
    
    ret = SecKeyRawVerify(publicKeyRef, kSecPaddingPKCS1SHA256, sha1dg.bytes, sha1dg.length,sig, siglen);
    NSAssert(ret==errSecSuccess, @"验证签名失败");
    
    if (ret==errSecSuccess) {
        NSLog(@"SIGN VERIFY PASS");
    }
}




@end
