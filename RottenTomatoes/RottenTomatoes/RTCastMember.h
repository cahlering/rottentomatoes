//
//  RTCastMember.h
//  RottenTomatoes
//
//  Created by Chris Ahlering on 3/18/14.
//  Copyright (c) 2014 Chris Ahlering. All rights reserved.
//

#import "MUJSONResponseSerializer.h"

@interface RTCastMember : MUJSONResponseObject

@property (nonatomic) NSInteger *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *characters;

@end
