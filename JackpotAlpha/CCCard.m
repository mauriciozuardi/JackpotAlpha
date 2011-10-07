//
//  CCCard.m
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/7/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

#import "CCCard.h"


@implementation CCCard
@synthesize yAlvo;

-(id)initWithFile:(NSString *)filename {
    [super initWithFile:filename];
    [self setYAlvo:self.position.y];
    return self;
}

@end