//
//  Coluna.m
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/11/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

#import "Coluna.h"

@implementation Coluna
@synthesize speed;
@synthesize readyToSnap;

- (id)init {
    self = [super init];
    if (self) {
        self.speed = 0;
        self.readyToSnap = NO;
    }
    return self;
}

@end
