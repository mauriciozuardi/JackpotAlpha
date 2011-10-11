//
//  Coluna.h
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/11/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coluna : NSObject {
    float speed;
    BOOL readyToSnap;
}

@property (nonatomic, readwrite) float speed;
@property (nonatomic, readwrite) BOOL readyToSnap;

@end