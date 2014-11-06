//
//  RISettings.m
//  Rocket
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import "RISettings.h"

@implementation RISettings

-(void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

@end
