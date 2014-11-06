//
//  RocketTests.m
//  RocketTests
//
//  Created by Simone Kalb on 15/09/14.
//
//

#import <XCTest/XCTest.h>

@interface RocketTests : XCTestCase

@end

@implementation RocketTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
