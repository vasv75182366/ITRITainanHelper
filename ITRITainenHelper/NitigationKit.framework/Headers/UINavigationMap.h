//
//  UIWebView+NavigationMap.h
//  NitigationKit
//
//  Created by T500 on 2017/4/5.
//  Copyright © 2017年 T500. All rights reserved.
//

#import <UIKit/UIKit.h>

enum Instruction {
    INSTRUCTION_SET_TARGET, INSTRUCTION_NAVIGATION
};

enum NavigationMapStatus {
    NAVIGATION_DOCUMENT_LOADED, NAVIGATION_MAP_LOADED
};

@protocol NavigationMapListener <NSObject>
@optional
-(void)onMapStatus:(enum NavigationMapStatus)status;
-(void)onInstructionUpdate:(enum Instruction)instruction result:(NSString *)result;
@end

IB_DESIGNABLE
@interface UINavigationMap: UIWebView

@property (nonatomic, copy)IBInspectable NSString *projectId;
@property (nonatomic, weak)id <NavigationMapListener> navigationMapListener;
@property (nonatomic, assign)BOOL isShowingRoute;
@property (nonatomic, assign)NSInteger zoomLevel;

-(instancetype)initWithProjectId:(NSString *)projectId;
-(void)runMap;
-(void)startBLEScan;
-(void)stopBLEScan;
-(void)enableShowingRoute;
-(void)disableShowingRoute;
-(void)showMap:(NSString *)fieldId;
-(NSString *)getCurrentLoadedFieldName;
-(void)setTarget:(NSString *)fieldId x:(NSInteger)x y:(NSInteger)y;
-(void)setTarget:(NSString *)fieldId x:(NSInteger)x y:(NSInteger)y nearByPathId:(NSString *)nearByPathId;
-(void)showTargetAt:(NSInteger)x y:(NSInteger)y;
-(void)hideTarget;
-(void)hidePin;
-(void)startNavigation;
-(void)stopNavigation;
-(void)startPositioning;
-(void)stopPositioning;

@end
