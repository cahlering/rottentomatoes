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
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSArray *cast;
@property (nonatomic, strong) NSDictionary *posters;

@end
