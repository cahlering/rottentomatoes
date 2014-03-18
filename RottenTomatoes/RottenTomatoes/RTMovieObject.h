//
//  RTMovieObject.h
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/16/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUJsonResponseSerializer.h"

@interface RTMovieObject : MUJSONResponseObject

@property (nonatomic) NSInteger *id;
@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *description;
@property (nonatomic, weak) NSArray *cast;
@property (nonatomic, weak) NSArray *posters;

@end
