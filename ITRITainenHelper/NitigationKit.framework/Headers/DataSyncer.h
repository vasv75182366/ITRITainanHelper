//
//  NSObject+DataSyncer.h
//  NitigationKit
//
//  Created by T500 on 2017/3/20.
//  Copyright © 2017年 ITRI. All rights reserved.
//

#import <Foundation/Foundation.h>

enum SyncStatus {
    SYNC_START, SYNC_DONE, SYNC_INTERNET_FAIL, SYNC_SERVER_FAIL
};

@protocol DataSyncerListener <NSObject>

- (void)onSyncerStatus:(enum SyncStatus)status;
- (void)onGetData:(NSString *)pTableName data:(id)data;

@end

@interface DataSyncer: NSObject

@property (nonatomic, copy)NSString *projectId;
@property (readonly, nonatomic, strong)id project;
@property (readonly, nonatomic, copy)NSString *downloadDir;
@property (nonatomic, weak)id <DataSyncerListener> dataSyncListener;

+ (DataSyncer *)createInstance:(NSString *)projectId;
+ (DataSyncer *)getInstance;
-(void)startSync;
-(id)getBeacon:(NSString *)macAddress;
+(void)downloadFile:(NSString *)source destination:(NSString *)destination;
+(void)downloadMapFile:(NSString *)mapName;
-(void)syncProjectFile;
-(NSSet *)getProjectFileCache;
-(void)syncNavigationData;
-(id)getFieldMapById:(NSString *)fieldId;
-(void)getData:(NSString *)tableName time:(NSInteger)time;

@end

