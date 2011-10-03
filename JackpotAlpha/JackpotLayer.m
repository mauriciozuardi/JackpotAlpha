//
//  JackpotLayer.m
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/3/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

// Import the interfaces
#import "JackpotLayer.h"

CCSprite *card1;
CCSprite *card2;
CCSprite *card3;

//CCSprite *card4;
//CCSprite *card5;
//CCSprite *card6;
//CCSprite *card7;
//CCSprite *card8;
//CCSprite *card9;

// JackpotLayer implementation
@implementation JackpotLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	JackpotLayer *layer = [JackpotLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        //CRIA AS SPRITES        
//        int cardWidth = 112;
        int cardHeight = 150;
        
        //cria a sprite, a reposiciona e coloca na tela
        card1 = [CCSprite spriteWithFile:@"card1.png"];
        card1.position = ccp(240,(160-(0*cardHeight)));
        [self addChild:card1];
        
        //cria a sprite, a reposiciona e coloca na tela
        card2 = [CCSprite spriteWithFile:@"card2.png"];
        card2.position = ccp(240,(160-(1*cardHeight)));
        [self addChild:card2];
        
        //cria a sprite, a reposiciona e coloca na tela
        card3 = [CCSprite spriteWithFile:@"card3.png"];
        card3.position = ccp(240,(160-(2*cardHeight)));
        [self addChild:card3];
        
//        //coloca toscamente as outras para medir a performance
//        card4 = [CCSprite spriteWithFile:@"card1.png"]; card4.position = ccp(0,0); [self addChild:card4];
//        card5 = [CCSprite spriteWithFile:@"card1.png"]; card5.position = ccp(0,0); [self addChild:card5];
//        card6 = [CCSprite spriteWithFile:@"card1.png"]; card6.position = ccp(0,0); [self addChild:card6];
//        card7 = [CCSprite spriteWithFile:@"card1.png"]; card7.position = ccp(0,0); [self addChild:card7];
//        card8 = [CCSprite spriteWithFile:@"card1.png"]; card8.position = ccp(0,0); [self addChild:card8];
//        card9 = [CCSprite spriteWithFile:@"card1.png"]; card9.position = ccp(0,0); [self addChild:card9];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
