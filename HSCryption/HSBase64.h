/******************************************************************
 文件名称: Base64.h
 系统名称: 手机银行
 模块名称: 客户端
 类 名 称: Base64
 软件版权: 恒生电子股份有限公司
 功能说明: 
 系统版本: 
 开发人员: si xin
 开发时间: 09-8-13
 审核人员:
 相关文档:
 修改记录: 需求编号 修改日期 修改人员 修改说明
 
 ******************************************************************/


#import <Foundation/Foundation.h>


@interface HSBase64 : NSObject {
	
}

+ (NSData *)Base64EncodeWithChars:(const char*)lpszSrc  length:(int)length;
+ (NSData *)Base64DecodeWithChars:(const char*)lpszSrc;

@end

