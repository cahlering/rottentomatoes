//
//  RTMovieObject.m
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/16/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "RTMovieObject.h"
#import "RTCastMember.h"

@implementation RTMovieObject

-(id)init {
    
    if (self = [super init]) {
        self.propertyMap = @{
                             @"critics_consensus": @"description",
                             @"abridged_cast" : @"cast"
                             };
    }
    return self;
}

- (Class)classForElementsInArrayProperty:(NSString *)abridged_cast
{
    return [RTCastMember class];
}
@end
