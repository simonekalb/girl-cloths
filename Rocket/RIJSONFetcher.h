//
//  RIJSONFetcher.h
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import <Foundation/Foundation.h>

typedef void(^APICompletionHandler)(BOOL completed, NSError *error, id response);

@interface RIJSONFetcher : NSObject

+(RIJSONFetcher *) sharedInstance;
-(void)requestWithCompletion:(APICompletionHandler)handler andParameters:(NSDictionary *)parameters;

-(void)sortByType:(NSString *)type withCompletion:(APICompletionHandler)handler;
@end
