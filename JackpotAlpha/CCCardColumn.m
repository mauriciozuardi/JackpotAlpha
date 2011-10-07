//
//  CCCardColumn.m
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/7/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

#import "CCCardColumn.h"


@implementation CCCardColumn
@synthesize snapTargetsDefined, speed;


-(id)init{
    [super init];
    self.snapTargetsDefined = NO;
    self.speed = 0;
    return self;
}

@end
