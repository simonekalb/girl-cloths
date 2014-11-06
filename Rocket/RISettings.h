//
//  RISettings.h
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SORT_KEY_CLOTH) {
    SORT_KEY_CLOTH_POPULARITY,
    SORT_KEY_CLOTH_PRICE,
    SORT_KEY_CLOTH_BRAND,
    SORT_KEY_CLOTH_NAME
};

#define IMAGE_ITEM_TO_DISPLAY 0
#define WOMAN_CLOTH_DATA_INSERTION_FINISHED @"WCDataInsertionTerminated"
#define DATABASE_POPULATED @"DatabasePopulated"
#define MAX_ITEMS @"5"
#define DIR @"desc"
#define PAGE @"1"

@interface RISettings : NSObject

- (void)saveContext;

@end
