//
//  RTMovieResponse.m
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/18/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "RTMovieResponse.h"
#import "RTMovieObject.h"

@implementation RTMovieResponse

- (Class)classForElementsInArrayProperty:(NSString *)movies
{
    return [RTMovieObject class];
}

@end
