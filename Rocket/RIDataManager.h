//
//  RIDataManager.h
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import <Foundation/Foundation.h>

@interface RIDataManager : NSObject

@property(strong, nonatomic) NSMutableArray *productsCatalog;
@property(strong, nonatomic) NSArray *result;

-(void)fetch;
-(void)fetchWithKey:(NSString *)sortKey;
-(void)fillProductCatalogWithKey:(NSString *)key;
-(void)fillProductCatalog;

@end
