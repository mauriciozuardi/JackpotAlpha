//
//  CCCardColumn.h
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/7/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCCardColumn : NSObject {
    BOOL snapTargetsDefined;
    float speed;
}

@property (nonatomic, readwrite) BOOL snapTargetsDefined;
@property (nonatomic, readwrite) float speed;

@end
