//
//  JackpotLayer.h
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/3/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCTouchDispatcher.h"

// JackpotLayer
@interface JackpotLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

// retorna um número randômico usando arc4random
-(int)getRandomNumber:(int)from to:(int)to;

// compara 3 distancias e retorna o "index" da mais próxima
-(int)getClosestCardIndexWithD1:(float)d1 D2:(float)d2 andD3:(float)d3;

@end
