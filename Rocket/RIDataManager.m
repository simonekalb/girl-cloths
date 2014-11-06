//
//  RIDataManager.m
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import "RIDataManager.h"
#import "RIJSONFetcher.h"
#import "WomanCloth.h"


@implementation RIDataManager

/* Calls API to fetch clothes data */
-(void)fetch {
    [[RIJSONFetcher sharedInstance] requestWithCompletion:^(BOOL completed, NSError *error, id response) {
        _result = response[@"metadata"][@"results"];
        [_productsCatalog removeAllObjects];
        [self parse];
    } andParameters:nil];
}


/* Calls API to fetch clothes data with a specified key */
-(void)fetchWithKey:(NSString *)sortKey {
    [[RIJSONFetcher sharedInstance] sortByType:sortKey withCompletion:^(BOOL completed, NSError *error, id response) {
        _result = response[@"metadata"][@"results"];
        [_productsCatalog removeAllObjects];
        [self parse];

    }];
}

/* Iterates through the result dictionary and creates an entry into the DB for each cloth */
-(void)parse {
    for (NSDictionary *cloth in _result) {
        if(![self productAlreadyExists:cloth[@"id"]]) {
            
            WomanCloth *aCloth = [WomanCloth MR_createEntity];
            aCloth.cid = [cloth[@"id"] longLongValue];
            aCloth.productName = cloth[@"data"][@"name"];
            aCloth.brand = cloth[@"data"][@"brand"];
            aCloth.price = [cloth[@"data"][@"price"] floatValue];
            NSMutableArray *imagesArray = [NSMutableArray array];
            for (int i = 0 ; i < [cloth[@"images"] count]; i++) {
                [imagesArray addObject:cloth[@"images"][i][@"path"]];
            }
            aCloth.imageNames = [NSArray arrayWithArray:imagesArray];
        }
    }
    
    /* Calling the Settings class for saving data into DB */
    RISettings *settings = [RISettings new];
    [settings saveContext];
    
    [self fillProductCatalog];
    
    /* 
        Sending a notification to View Controller saying that
        Data Manager finished to parse data and inserted all clothes in
        DB.
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:WOMAN_CLOTH_DATA_INSERTION_FINISHED object:self userInfo:nil];
}

/* Query the DB for all the clothes ordered by popularity */
-(void)fillProductCatalog {
    if(!_productsCatalog) _productsCatalog = [NSMutableArray new];
    _productsCatalog = [[WomanCloth MR_findAll] mutableCopy];
}

-(BOOL)productAlreadyExists:(NSString *)clothId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cid == %@", clothId];
    return [WomanCloth MR_countOfEntitiesWithPredicate:predicate] > 0;
}

/* Query the DB for all the clothes ordered by a specific key */
-(void)fillProductCatalogWithKey:(NSString *)key {
    if(!_productsCatalog) _productsCatalog = [NSMutableArray new];
    
        _productsCatalog = [[WomanCloth MR_findAllSortedBy:key ascending:YES] mutableCopy];
}

@end
