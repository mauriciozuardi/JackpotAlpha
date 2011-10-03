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
CCSprite *escolhido;
float dE;

CCSprite *card1;
CCSprite *card2;
CCSprite *card3;
float yAlvoC1;
float yAlvoC2;
float yAlvoC3;
BOOL snapTargetsDefinedColuna1 = NO;
float speedColuna1;

CCSprite *card4;
CCSprite *card5;
CCSprite *card6;
float yAlvoC4;
float yAlvoC5;
float yAlvoC6;
BOOL snapTargetsDefinedColuna2 = NO;
float speedColuna2;

CCSprite *card7;
CCSprite *card8;
CCSprite *card9;
float yAlvoC7;
float yAlvoC8;
float yAlvoC9;
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
        card1 = [CCSprite spriteWithFile:@"card1.png"]; i = -1; j = 0;
        card1.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC1 = card1.position.y;
        [self addChild:card1];
        
        //cria a sprite, a reposiciona e coloca na tela
        card2 = [CCSprite spriteWithFile:@"card2.png"]; i = -1; j = 1;
        card2.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC2 = card2.position.y;
        [self addChild:card2];
        
        //cria a sprite, a reposiciona e coloca na tela
        card3 = [CCSprite spriteWithFile:@"card3.png"]; i = -1; j = 2;
        card3.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC3 = card3.position.y;
        [self addChild:card3];
        
        //cria a sprite, a reposiciona e coloca na tela
        card4 = [CCSprite spriteWithFile:@"card1.png"]; i = 0; j = 0;
        card4.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC4 = card4.position.y;
        [self addChild:card4];
        
        //cria a sprite, a reposiciona e coloca na tela
        card5 = [CCSprite spriteWithFile:@"card2.png"]; i = 0; j = 1;
        card5.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC5 = card5.position.y;
        [self addChild:card5];
        
        //cria a sprite, a reposiciona e coloca na tela
        card6 = [CCSprite spriteWithFile:@"card3.png"]; i = 0; j = 2;
        card6.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC6 = card6.position.y;
        [self addChild:card6];
        
        //cria a sprite, a reposiciona e coloca na tela
        card7 = [CCSprite spriteWithFile:@"card1.png"]; i = 1; j = 0;
        card7.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC7 = card7.position.y;
        [self addChild:card7];
        
        //cria a sprite, a reposiciona e coloca na tela
        card8 = [CCSprite spriteWithFile:@"card2.png"]; i = 1; j = 1;
        card8.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC8 = card8.position.y;
        [self addChild:card8];
        
        //cria a sprite, a reposiciona e coloca na tela
        card9 = [CCSprite spriteWithFile:@"card3.png"]; i = 1; j = 2;
        card9.position = ccp(defaultCardX + (i*(5+cardWidth)), defaultCardY + (j*cardHeight));
        yAlvoC9 = card9.position.y;
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
    
    int snapLimit = 3;
    
    //MANTÉM O GIRO
    //atualiza a nova posição das cartas (aplica a velocidade)
    card1.position = ccp(card1.position.x, card1.position.y - speedColuna1);
    card2.position = ccp(card2.position.x, card2.position.y - speedColuna1);
    card3.position = ccp(card3.position.x, card3.position.y - speedColuna1);
    
    card4.position = ccp(card4.position.x, card4.position.y - speedColuna2);
    card5.position = ccp(card5.position.x, card5.position.y - speedColuna2);
    card6.position = ccp(card6.position.x, card6.position.y - speedColuna2);
    
    card7.position = ccp(card7.position.x, card7.position.y - speedColuna3);
    card8.position = ccp(card8.position.x, card8.position.y - speedColuna3);
    card9.position = ccp(card9.position.x, card9.position.y - speedColuna3);
    
    //aplica o atrito
    speedColuna1 *= .98;
    speedColuna2 *= .98;
    speedColuna3 *= .98;
    
    //SNAP COLUNA 1
    if (speedColuna1 < snapLimit) {
        //define as distancias
        float d1 = card1.position.y - defaultCardY;
        float d2 = card2.position.y - defaultCardY;
        float d3 = card3.position.y - defaultCardY;

        //identifica quem está mais perto e define os alvos
        if(!snapTargetsDefinedColuna1){
            if(abs(d1)<cardHeight/2){
                //card 1 é a mais próxima
                yAlvoC1 = defaultCardY;
                //define o alvo das outras
                yAlvoC2 = round(card2.position.y - d1);
                yAlvoC3 = round(card3.position.y - d1);
                NSLog(@"1 - Dark Ripper (%f, %f, %f)", yAlvoC1, yAlvoC2, yAlvoC3);
            } else if(abs(d2)<cardHeight/2){
                //card 2 é a mais próxima
                yAlvoC2 = defaultCardY;
                //define o alvo das outras
                yAlvoC1 = round(card1.position.y - d2);
                yAlvoC3 = round(card3.position.y - d2);
                NSLog(@"2 - Forest Brute (%f, %f, %f)", yAlvoC1, yAlvoC2, yAlvoC3);
            } else if(abs(d3)<cardHeight/2){
                //card 3 é a mais próxima
                yAlvoC3 = defaultCardY;
                //define o alvo das outras
                yAlvoC2 = round(card2.position.y - d3);
                yAlvoC1 = round(card1.position.y - d3);
                NSLog(@"3 - Tesla, the Hastah (%f, %f, %f)", yAlvoC1, yAlvoC2, yAlvoC3);
            }
            
            //avisa que já calculou
            snapTargetsDefinedColuna1 = YES;
            
        } else {
            //SMOOTH
            speedColuna1 *= .5;
            card1.position = ccp(card1.position.x, card1.position.y + (yAlvoC1 - card1.position.y)/20);
            card2.position = ccp(card2.position.x, card2.position.y + (yAlvoC2 - card2.position.y)/20);
            card3.position = ccp(card3.position.x, card3.position.y + (yAlvoC3 - card3.position.y)/20);        
        }
        
    } else {
        //HARD
        if(card1.position.y < defaultCardY - (1.5 * cardHeight)){
            card1.position = ccp(card1.position.x, card1.position.y + (3*cardHeight));
        }
        if(card2.position.y < defaultCardY - (1.5 * cardHeight)){
            card2.position = ccp(card2.position.x, card2.position.y + (3*cardHeight));
        }
        if(card3.position.y < defaultCardY - (1.5 * cardHeight)){
            card3.position = ccp(card3.position.x, card3.position.y + (3*cardHeight));
        }
    }
    
    //SNAP COLUNA 2
    if (speedColuna2 < snapLimit) {
        //define as distancias
        float d4 = card4.position.y - defaultCardY;
        float d5 = card5.position.y - defaultCardY;
        float d6 = card6.position.y - defaultCardY;
        
        //identifica quem está mais perto e define os alvos
        if(!snapTargetsDefinedColuna2){
            if(abs(d4)<cardHeight/2){
                //card 4 é a mais próxima
                yAlvoC4 = defaultCardY;
                //define o alvo das outras
                yAlvoC5 = round(card5.position.y - d4);
                yAlvoC6 = round(card6.position.y - d4);
                NSLog(@"1 - Dark Ripper (col.2) (%f, %f, %f)", yAlvoC4, yAlvoC5, yAlvoC6);
            } else if(abs(d5)<cardHeight/2){
                //card 5 é a mais próxima
                yAlvoC5 = defaultCardY;
                //define o alvo das outras
                yAlvoC4 = round(card4.position.y - d5);
                yAlvoC6 = round(card6.position.y - d5);
                NSLog(@"2 - Forest Brute (col.2) (%f, %f, %f)", yAlvoC4, yAlvoC5, yAlvoC6);
            } else if(abs(d6)<cardHeight/2){
                //card 6 é a mais próxima
                yAlvoC6 = defaultCardY;
                //define o alvo das outras
                yAlvoC5 = round(card5.position.y - d6);
                yAlvoC4 = round(card4.position.y - d6);
                NSLog(@"3 - Tesla, the Hastah (col.2) (%f, %f, %f)", yAlvoC4, yAlvoC5, yAlvoC6);
            }
            
            //avisa que já calculou
            snapTargetsDefinedColuna2 = YES;
            
        } else {
            //SMOOTH
            speedColuna2 *= .5;
            card4.position = ccp(card4.position.x, card4.position.y + (yAlvoC4 - card4.position.y)/20);
            card5.position = ccp(card5.position.x, card5.position.y + (yAlvoC5 - card5.position.y)/20);
            card6.position = ccp(card6.position.x, card6.position.y + (yAlvoC6 - card6.position.y)/20);        
        }
        
    } else {
        //HARD
        if(card4.position.y < defaultCardY - (1.5 * cardHeight)){
            card4.position = ccp(card4.position.x, card4.position.y + (3*cardHeight));
        }
        if(card5.position.y < defaultCardY - (1.5 * cardHeight)){
            card5.position = ccp(card5.position.x, card5.position.y + (3*cardHeight));
        }
        if(card6.position.y < defaultCardY - (1.5 * cardHeight)){
            card6.position = ccp(card6.position.x, card6.position.y + (3*cardHeight));
        }
    }

    
    //SNAP COLUNA 3
    if (speedColuna3 < snapLimit) {
        //define as distancias
        float d7 = card7.position.y - defaultCardY;
        float d8 = card8.position.y - defaultCardY;
        float d9 = card9.position.y - defaultCardY;
        
        //identifica quem está mais perto e define os alvos
        if(!snapTargetsDefinedColuna3){
            if(abs(d7)<cardHeight/2){
                //card 4 é a mais próxima
                yAlvoC7 = defaultCardY;
                //define o alvo das outras
                yAlvoC8 = round(card8.position.y - d7);
                yAlvoC9 = round(card9.position.y - d7);
                NSLog(@"1 - Dark Ripper (col.3) (%f, %f, %f)", yAlvoC7, yAlvoC8, yAlvoC9);
            } else if(abs(d8)<cardHeight/2){
                //card 5 é a mais próxima
                yAlvoC8 = defaultCardY;
                //define o alvo das outras
                yAlvoC7 = round(card7.position.y - d8);
                yAlvoC9 = round(card9.position.y - d8);
                NSLog(@"2 - Forest Brute (col.3) (%f, %f, %f)", yAlvoC7, yAlvoC8, yAlvoC9);
            } else if(abs(d9)<cardHeight/2){
                //card 6 é a mais próxima
                yAlvoC9 = defaultCardY;
                //define o alvo das outras
                yAlvoC8 = round(card8.position.y - d9);
                yAlvoC7 = round(card7.position.y - d9);
                NSLog(@"3 - Tesla, the Hastah (col.3) (%f, %f, %f)", yAlvoC7, yAlvoC8, yAlvoC9);
            }
            
            //avisa que já calculou
            snapTargetsDefinedColuna3 = YES;
            
        } else {
            //SMOOTH
            speedColuna3 *= .5;
            card7.position = ccp(card7.position.x, card7.position.y + (yAlvoC7 - card7.position.y)/20);
            card8.position = ccp(card8.position.x, card8.position.y + (yAlvoC8 - card8.position.y)/20);
            card9.position = ccp(card9.position.x, card9.position.y + (yAlvoC9 - card9.position.y)/20);        
        }
        
    } else {
        //HARD
        if(card7.position.y < defaultCardY - (1.5 * cardHeight)){
            card7.position = ccp(card7.position.x, card7.position.y + (3*cardHeight));
        }
        if(card8.position.y < defaultCardY - (1.5 * cardHeight)){
            card8.position = ccp(card8.position.x, card8.position.y + (3*cardHeight));
        }
        if(card9.position.y < defaultCardY - (1.5 * cardHeight)){
            card9.position = ccp(card9.position.x, card9.position.y + (3*cardHeight));
        }
    }
}

-(int)getRandomNumber:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //define um novo valor para a velocidade das colunas
    speedColuna1 = [self getRandomNumber:50 to:100];
    speedColuna2 = [self getRandomNumber:50 to:100];
    speedColuna3 = [self getRandomNumber:50 to:100];
    
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
