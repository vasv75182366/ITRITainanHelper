//
//  Utilities.h
//  DefenDoor
//
//  Created by itri on 2015/9/14.
//  Copyright (c) 2015年 glate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

+ (UIImage *)getButtonImage:(NSString *)pForName;
+ (UIImage *)getCameraButtonImage:(NSString *)pForName;
+ (id)findViewController:(UINavigationController *)pNavigationController class:(Class) pClass;
+ (BOOL)checkMacAddress:(NSString *)pMacAddress;

// for paths
+ (NSString *)getTempPath;
+ (NSString *)getDocumentPath;
+ (NSURL *)getDocumentUrl;
+(BOOL)removeFile:(NSString *)file;
+(BOOL)checkFileExist:(NSString *)file;
+(NSString *)objectToJson:(id)object;
+(NSString *)getDeviceModel;

@end
