//
//  JackpotLayer.m
//  JackpotAlpha
//
//  Created by Mauricio Zuardi on 10/3/11.
//  Copyright 2011 mnmo.com.br. All rights reserved.
//

// Import the interfaces
#import "JackpotLayer.h"
#import "CCCard.h"

int cardWidth = 112;
int cardHeight = 150;
int defaultCardX = 240;
int defaultCardY = 160;

CCSprite *slot;

CCCard *card1;
CCCard *card2;
CCCard *card3;
BOOL snapTargetsDefinedColuna1 = NO;
float speedColuna1;

CCCard *card4;
CCCard *card5;
CCCard *card6;
BOOL snapTargetsDefinedColuna2 = NO;
float speedColuna2;

CCCard *card7;
CCCard *card8;
CCCard *card9;
BOOL snapTargetsDefinedColuna3 = NO;
float speedColuna3;


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
        
        //define a velocidade inicial das colunas
        speedColuna1 = 0;
        speedColuna2 = 0;
        speedColuna3 = 0;
        
        
        
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
    
    int snapLimit = 15;
    float atrito = .95;
    
    //MANTÉM O GIRO
    //aplica a velocidade
    CGPoint newC1Position = ccp(card1.position.x, card1.position.y - speedColuna1);
    CGPoint newC2Position = ccp(card2.position.x, card2.position.y - speedColuna1);
    CGPoint newC3Position = ccp(card3.position.x, card3.position.y - speedColuna1);
    
    //define as distancias
    float d1 = card1.position.y - defaultCardY;
    float d2 = card2.position.y - defaultCardY;
    float d3 = card3.position.y - defaultCardY;
    
    //define quem está mais próximo
    int cci1 = [self getClosestCardIndexWithD1:d1 D2:d2 andD3:d3];
    
    //SNAP COLUNA 1
    if (speedColuna1 < snapLimit && speedColuna1 > 0 && !snapTargetsDefinedColuna1) {
        snapTargetsDefinedColuna1 = YES;
    } else if (snapTargetsDefinedColuna1){
        //NEW SMOOTH
        float div = 30;
        float speedDelta1 = 0;
        
        if (cci1 == 1) {
            speedDelta1 = d1/div;
        } else if (cci1 == 2) {
            speedDelta1 = d2/div;
        } else if (cci1 == 3) {
            speedDelta1 = d3/div;
        }

        speedColuna1 += speedDelta1;
        speedColuna1 *= .95;
        //SNAP FINAL
        if(abs(speedDelta1) < .001){
            snapTargetsDefinedColuna1 = NO;
//            speedColuna1 = 0;
            NSLog(@"Coluna1: Carta %d", cci1);
        }
    }
    
//    //SNAP COLUNA 2
//    if (speedColuna2 < snapLimit) {
//        //define as distancias
//        float d4 = card4.position.y - defaultCardY;
//        float d5 = card5.position.y - defaultCardY;
//        float d6 = card6.position.y - defaultCardY;
//        
//        //identifica quem está mais perto e define os alvos
//        if(!snapTargetsDefinedColuna2){
//            if(abs(d4)<cardHeight/2){
//                //card 4 é a mais próxima
//                card4.yAlvo = defaultCardY;
//                //define o alvo das outras
//                card5.yAlvo = round(card5.position.y - d4);
//                card6.yAlvo = round(card6.position.y - d4);
//                NSLog(@"1 - Dark Ripper (col.2) (%f, %f, %f)", card4.yAlvo, card5.yAlvo, card6.yAlvo);
//            } else if(abs(d5)<cardHeight/2){
//                //card 5 é a mais próxima
//                card5.yAlvo = defaultCardY;
//                //define o alvo das outras
//                card4.yAlvo = round(card4.position.y - d5);
//                card6.yAlvo = round(card6.position.y - d5);
//                NSLog(@"2 - Forest Brute (col.2) (%f, %f, %f)", card4.yAlvo, card5.yAlvo, card6.yAlvo);
//            } else if(abs(d6)<cardHeight/2){
//                //card 6 é a mais próxima
//                card6.yAlvo = defaultCardY;
//                //define o alvo das outras
//                card5.yAlvo = round(card5.position.y - d6);
//                card4.yAlvo = round(card4.position.y - d6);
//                NSLog(@"3 - Tesla, the Hastah (col.2) (%f, %f, %f)", card4.yAlvo, card5.yAlvo, card6.yAlvo);
//            }
//            
//            //avisa que já calculou
//            snapTargetsDefinedColuna2 = YES;
//            
//        } else {
//            //SMOOTH
//            speedColuna2 *= .5;
//            card4.position = ccp(card4.position.x, card4.position.y + (card4.yAlvo - card4.position.y)/20);
//            card5.position = ccp(card5.position.x, card5.position.y + (card5.yAlvo - card5.position.y)/20);
//            card6.position = ccp(card6.position.x, card6.position.y + (card6.yAlvo - card6.position.y)/20);        
//        }
//        
//    } else {
//        //HARD
//        if(card4.position.y < defaultCardY - (1.5 * cardHeight)){
//            card4.position = ccp(card4.position.x, card4.position.y + (3*cardHeight));
//        }
//        if(card5.position.y < defaultCardY - (1.5 * cardHeight)){
//            card5.position = ccp(card5.position.x, card5.position.y + (3*cardHeight));
//        }
//        if(card6.position.y < defaultCardY - (1.5 * cardHeight)){
//            card6.position = ccp(card6.position.x, card6.position.y + (3*cardHeight));
//        }
//    }
//
//    
//    //SNAP COLUNA 3
//    if (speedColuna3 < snapLimit) {
//        //define as distancias
//        float d7 = card7.position.y - defaultCardY;
//        float d8 = card8.position.y - defaultCardY;
//        float d9 = card9.position.y - defaultCardY;
//        
//        //identifica quem está mais perto e define os alvos
//        if(!snapTargetsDefinedColuna3){
//            if(abs(d7)<cardHeight/2){
//                //card 4 é a mais próxima
//                card7.yAlvo = defaultCardY;
//                //define o alvo das outras
//                card8.yAlvo = round(card8.position.y - d7);
//                card9.yAlvo = round(card9.position.y - d7);
//                NSLog(@"1 - Dark Ripper (col.3) (%f, %f, %f)", card7.yAlvo, card8.yAlvo, card9.yAlvo);
//            } else if(abs(d8)<cardHeight/2){
//                //card 5 é a mais próxima
//                card8.yAlvo = defaultCardY;
//                //define o alvo das outras
//                card7.yAlvo = round(card7.position.y - d8);
//                card9.yAlvo = round(card9.position.y - d8);
//                NSLog(@"2 - Forest Brute (col.3) (%f, %f, %f)", card7.yAlvo, card8.yAlvo, card9.yAlvo);
//            } else if(abs(d9)<cardHeight/2){
//                //card 6 é a mais próxima
//                card9.yAlvo = defaultCardY;
//                //define o alvo das outras
//                card8.yAlvo = round(card8.position.y - d9);
//                card7.yAlvo = round(card7.position.y - d9);
//                NSLog(@"3 - Tesla, the Hastah (col.3) (%f, %f, %f)", card7.yAlvo, card8.yAlvo, card9.yAlvo);
//            }
//            
//            //avisa que já calculou
//            snapTargetsDefinedColuna3 = YES;
//            
//        } else {
//            //SMOOTH
//            speedColuna3 *= .5;
//            card7.position = ccp(card7.position.x, card7.position.y + (card7.yAlvo - card7.position.y)/20);
//            card8.position = ccp(card8.position.x, card8.position.y + (card8.yAlvo - card8.position.y)/20);
//            card9.position = ccp(card9.position.x, card9.position.y + (card9.yAlvo - card9.position.y)/20);        
//        }
//        
//    } else {
//        //HARD
//        if(card7.position.y < defaultCardY - (1.5 * cardHeight)){
//            card7.position = ccp(card7.position.x, card7.position.y + (3*cardHeight));
//        }
//        if(card8.position.y < defaultCardY - (1.5 * cardHeight)){
//            card8.position = ccp(card8.position.x, card8.position.y + (3*cardHeight));
//        }
//        if(card9.position.y < defaultCardY - (1.5 * cardHeight)){
//            card9.position = ccp(card9.position.x, card9.position.y + (3*cardHeight));
//        }
//    }
    
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
    card1.position = newC1Position;
    card2.position = newC2Position;
    card3.position = newC3Position;
    
    //aplica o atrito
    speedColuna1 *= atrito;
    speedColuna2 *= atrito;
    speedColuna3 *= atrito;
}

-(int)getRandomNumber:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

-(int)getClosestCardIndexWithD1:(float)d1 D2:(float)d2 andD3:(float)d3 {
    if (abs(d1) < min(abs(d2), abs(d3))) {
        return 1;
    } else if (abs(d2) < min(abs(d1), abs(d3))) {
        return 2;
    } else if (abs(d3) < min(abs(d2), abs(d1))) {
        return 3;
    } else if (abs(d1) <= min(abs(d2), abs(d3))) {
        return 1;
    } else if (abs(d2) <= min(abs(d1), abs(d3))) {
        return 2;
    } else if (abs(d3) <= min(abs(d2), abs(d1))) {
        return 3;
    }
    return 0;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //define um novo valor para a velocidade das colunas
    speedColuna1 = [self getRandomNumber:50 to:70];
    speedColuna2 = [self getRandomNumber:50 to:70];
    speedColuna3 = [self getRandomNumber:50 to:70];
    
    //reseta a flag
    snapTargetsDefinedColuna1 = NO;
    snapTargetsDefinedColuna2 = NO;
    snapTargetsDefinedColuna3 = NO;
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
