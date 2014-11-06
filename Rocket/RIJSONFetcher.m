//
//  RIJSONFetcher.m
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import "RIJSONFetcher.h"
#import <AFNetworking.h>

static NSString * const endPoint = @"https://www.zalora.com.my/mobile-api/women/clothing";

@implementation RIJSONFetcher

static RIJSONFetcher* _sharedInstance;

-(id)init {
    if(!self) {
        self = [super init];
    }
    return self;
}

+(RIJSONFetcher *) sharedInstance {
	if ( !_sharedInstance ) {
        _sharedInstance = [[RIJSONFetcher alloc] init];
	}
	return _sharedInstance;
}

-(void)requestWithCompletion:(APICompletionHandler)handler andParameters:(NSDictionary *)parameters{
    
    NSURL *URLService = [NSURL URLWithString:endPoint];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:URLService];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
         if (responseDictionary)
         {
             handler(YES, nil, responseDictionary);
             
         } else {
             
             handler(YES, nil, responseDictionary);
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:NSLocalizedString(@"Unable to correctly load the service, please try again later", nil)  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         
         [alert show];
         
         handler(YES, error, nil);
     }];
}

-(void)sortByType:(NSString *)type withCompletion:(APICompletionHandler)handler {
    
    NSDictionary *parameters = @{@"maxitems": MAX_ITEMS,
                                 @"page": PAGE,
                                 @"sort": type,
                                 @"dir": DIR
                                 };
    
    [self requestWithCompletion:^(BOOL completed, NSError *error, id response) {
        handler(completed, error, response);
    }
    andParameters:parameters];
}

@end
