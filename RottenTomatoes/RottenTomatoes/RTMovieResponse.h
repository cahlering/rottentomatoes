//
//  RTMovieResponse.h
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/18/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "MUJSONResponseSerializer.h"

@interface RTMovieResponse : MUJSONResponseObject

@property (strong, nonatomic) NSArray *movies;

@end
