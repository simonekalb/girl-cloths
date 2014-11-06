//
//  WomanCloth.h
//  Rocket
//
//  Created by Simone Kalb on 15/10/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WomanCloth : NSManagedObject

@property (nonatomic, retain) NSString * brand;
@property (nonatomic) int64_t cid;
@property (nonatomic, retain) id imageNames;
@property (nonatomic) float price;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSManagedObject *relationship;

@end
