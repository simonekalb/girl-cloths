//
//  RISharedInstanceTest.m
//  Rocket
//
//  Created by Simone Kalb on 15/10/14.
//
//

#import <XCTest/XCTest.h>
#import "RIJSONFetcher.h"

@interface RISharedInstanceTest : XCTestCase

@end

@implementation RISharedInstanceTest

#pragma mark - helper methods

- (RIJSONFetcher *)createUniqueInstance {
    
    return [[RIJSONFetcher alloc] init];
    
}

- (RIJSONFetcher *)getSharedInstance {
    
    return [RIJSONFetcher sharedInstance];
    
}

#pragma mark - tests

- (void)testSingletonSharedInstanceCreated {
    
    XCTAssertNotNil([self getSharedInstance]);
    
}

- (void)testSingletonUniqueInstanceCreated {
    
    XCTAssertNotNil([self createUniqueInstance]);
    
}

- (void)testSingletonReturnsSameSharedInstanceTwice {
    
    RIJSONFetcher *s1 = [self getSharedInstance];
    XCTAssertEqual(s1, [self getSharedInstance]);
    
}

- (void)testSingletonSharedInstanceSeparateFromUniqueInstance {
    
    RIJSONFetcher *s1 = [self getSharedInstance];
    XCTAssertNotEqual(s1, [self createUniqueInstance]);
}

- (void)testSingletonReturnsSeparateUniqueInstances {
    
    RIJSONFetcher *s1 = [self createUniqueInstance];
    XCTAssertNotEqual(s1, [self createUniqueInstance]);
}

@end
