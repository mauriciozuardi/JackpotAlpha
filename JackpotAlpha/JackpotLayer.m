//
//  JackpotLayer.m
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/3/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

// Import the interfaces
#import "JackpotLayer.h"

int cardWidth = 112;
int cardHeight = 150;
int defaultCardX = 240;
int defaultCardY = 160;

CCSprite *slot;

CCCard *card1;
CCCard *card2;
CCCard *card3;
Coluna *c1;
//BOOL snapTargetsDefinedColuna1 = NO;
//float speedColuna1;

CCCard *card4;
CCCard *card5;
CCCard *card6;
Coluna *c2;
//BOOL snapTargetsDefinedColuna2 = NO;
//float speedColuna2;

CCCard *card7;
CCCard *card8;
CCCard *card9;
Coluna *c3;
//BOOL snapTargetsDefinedColuna3 = NO;
//float speedColuna3;


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
        
        //CRIA AS COLUNAS
        c1 = [[Coluna alloc] init];
        c2 = [[Coluna alloc] init];
        c3 = [[Coluna alloc] init];
        
        
        //CRIA AS SPRITES        
        int i=0;
        int j=0;
        
        //cria a sprite, a reposiciona e coloca na tela
        card1 = [CCCard spriteWithFile:@"card1.png"]; i = -1; j = 0;
        card1.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card1];
        
        //cria a sprite, a reposiciona e coloca na tela
        card2 = [CCCard spriteWithFile:@"card2.png"]; i = -1; j = 1;
        card2.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card2];
        
        //cria a sprite, a reposiciona e coloca na tela
        card3 = [CCCard spriteWithFile:@"card3.png"]; i = -1; j = 2;
        card3.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card3];
        
        //cria a sprite, a reposiciona e coloca na tela
        card4 = [CCCard spriteWithFile:@"card1.png"]; i = 0; j = 0;
        card4.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card4];
        
        //cria a sprite, a reposiciona e coloca na tela
        card5 = [CCCard spriteWithFile:@"card2.png"]; i = 0; j = 1;
        card5.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card5];
        
        //cria a sprite, a reposiciona e coloca na tela
        card6 = [CCCard spriteWithFile:@"card3.png"]; i = 0; j = 2;
        card6.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card6];
        
        //cria a sprite, a reposiciona e coloca na tela
        card7 = [CCCard spriteWithFile:@"card1.png"]; i = 1; j = 0;
        card7.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card7];
        
        //cria a sprite, a reposiciona e coloca na tela
        card8 = [CCCard spriteWithFile:@"card2.png"]; i = 1; j = 1;
        card8.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card8];
        
        //cria a sprite, a reposiciona e coloca na tela
        card9 = [CCCard spriteWithFile:@"card3.png"]; i = 1; j = 2;
        card9.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        [self addChild:card9];
        
        //cria a sprite que cobre as cartas
        slot = [CCSprite spriteWithFile:@"SlotLocation.png"];
        slot.position = ccp(defaultCardX,defaultCardY);
        [self addChild:slot];
        
        
        //CRIA O "ENTERFRAME"
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        
//        //define a velocidade inicial das colunas
//        speedColuna1 = 0;
//        speedColuna2 = 0;
//        speedColuna3 = 0;
        
        
        //PERMITE OS TOQUES
        self.isTouchEnabled = YES;
	}
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void) nextFrame:(ccTime)dt {
    
    [self updateCardA:card1 andCardB:card2 andCardC:card3 atColum:c1];
    [self updateCardA:card4 andCardB:card5 andCardC:card6 atColum:c2];
    [self updateCardA:card7 andCardB:card8 andCardC:card9 atColum:c3];
    
}

-(int)getRandomNumber:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

-(void)updateCardA:(CCSprite*)cardA andCardB:(CCSprite*)cardB andCardC:(CCSprite*)cardC atColum:(Coluna*)c {
    
    int snapLimit = 15;
    float atrito = .95;
    
    //MANTÉM O GIRO
    //aplica a velocidade
    CGPoint newC1Position = ccp(cardA.position.x, cardA.position.y - c.speed);
    CGPoint newC2Position = ccp(cardB.position.x, cardB.position.y - c.speed);
    CGPoint newC3Position = ccp(cardC.position.x, cardC.position.y - c.speed);
    
    //define as distancias
    float d1 = newC1Position.y - defaultCardY;
    float d2 = newC2Position.y - defaultCardY;
    float d3 = newC3Position.y - defaultCardY;
    
    //define quem está mais próximo
    int cci1 = [self getClosestCardIndexWithD1:d1 D2:d2 andD3:d3];
    
    //SNAP TIME
    if (c.speed < snapLimit && c.speed > 0 && !c.readyToSnap) {
        c.readyToSnap = YES;
    } else if (c.readyToSnap){
        //SMOOTH
        float div = 80;
        float speedDelta1 = 0;
        
        if (cci1 == 1) {
            speedDelta1 = d1/div;
        } else if (cci1 == 2) {
            speedDelta1 = d2/div;
        } else if (cci1 == 3) {
            speedDelta1 = d3/div;
        }
        
        c.speed += speedDelta1;
        c.speed *= .95;
        //SNAP FINAL
        if(fabs(speedDelta1) < .0001){
            c.readyToSnap = NO;
            c.speed = 0;
            NSLog(@"Coluna1: Carta %d", cci1);
        }
    }

    
    //mantém dentro da tela
    if(newC1Position.y < defaultCardY - (1.5 * cardHeight)){
        newC1Position = ccp(newC1Position.x, newC1Position.y + (3*cardHeight));
    }
    if(newC2Position.y < defaultCardY - (1.5 * cardHeight)){
        newC2Position = ccp(newC2Position.x, newC2Position.y + (3*cardHeight));
    }
    if(newC3Position.y < defaultCardY - (1.5 * cardHeight)){
        newC3Position = ccp(newC3Position.x, newC3Position.y + (3*cardHeight));
    }
    
    //reposiciona as cartas
    cardA.position = newC1Position;
    cardB.position = newC2Position;
    cardC.position = newC3Position;
    
    //aplica o atrito
    c.speed *= atrito;
}

-(int)getClosestCardIndexWithD1:(float)d1 D2:(float)d2 andD3:(float)d3 {
    if (fabs(d1) < min(fabs(d2), fabs(d3))) {
        return 1;
    } else if (fabs(d2) < min(fabs(d1), fabs(d3))) {
        return 2;
    } else if (fabs(d3) < min(fabs(d2), fabs(d1))) {
        return 3;
    } else if (fabs(d1) <= min(fabs(d2), fabs(d3))) {
        return 1;
    } else if (fabs(d2) <= min(fabs(d1), fabs(d3))) {
        return 2;
    } else if (fabs(d3) <= min(fabs(d2), fabs(d1))) {
        return 3;
    }
    return 0;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //define um novo valor para a velocidade das colunas
    c1.speed = [self getRandomNumber:50 to:70];
    c2.speed = [self getRandomNumber:70 to:90];
    c3.speed = [self getRandomNumber:90 to:110];
    
    //reseta a flag
    c1.readyToSnap = NO;
    c2.readyToSnap = NO;
    c3.readyToSnap = NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
//	CGPoint location = [self convertTouchToNodeSpace: touch];
//    cocosGuyNewLocation = location;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
