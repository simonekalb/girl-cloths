//
//  WomanCloth.m
//  Rocket
//
//  Created by Simone Kalb on 15/10/14.
//
//

#import "WomanCloth.h"


@implementation WomanCloth

@dynamic brand;
@dynamic cid;
@dynamic imageNames;
@dynamic price;
@dynamic productName;
@dynamic relationship;

+ (Class)transformedValueClass
{
    return [NSArray class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

- (id)reverseTransformedValue:(id)value
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}


@end
