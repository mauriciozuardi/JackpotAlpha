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

CCSprite *card1;
CCSprite *card2;
CCSprite *card3;
float speedColuna1;
float card1_yAlvo;
float card2_yAlvo;
float card3_yAlvo;
BOOL snapTargetsDefinedColuna1 = NO;

//CCSprite *card4;
//CCSprite *card5;
//CCSprite *card6;
//float speedColuna2;
//float card4_yAlvo;
//float card5_yAlvo;
//float card6_yAlvo;

//CCSprite *card7;
//CCSprite *card8;
//CCSprite *card9;
//float speedColuna3;
//float card7_yAlvo;
//float card8_yAlvo;
//float card9_yAlvo;

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
        card1 = [CCSprite spriteWithFile:@"card1.png"]; i = 0; j = 0;
        card1.position = ccp(defaultCardX + (i*cardWidth), defaultCardY + (j*cardHeight));
        card1_yAlvo = card1.position.y;
        [self addChild:card1];
        
        //cria a sprite, a reposiciona e coloca na tela
        card2 = [CCSprite spriteWithFile:@"card2.png"]; i = 0; j = 1;
        card2.position = ccp(defaultCardX + (i*cardWidth), defaultCardY + (j*cardHeight));
        card2_yAlvo = card2.position.y;
        [self addChild:card2];
        
        //cria a sprite, a reposiciona e coloca na tela
        card3 = [CCSprite spriteWithFile:@"card3.png"]; i = 0; j = 2;
        card3.position = ccp(defaultCardX + (i*cardWidth), defaultCardY + (j*cardHeight));
        card3_yAlvo = card3.position.y;
        [self addChild:card3];
        
        //cria a sprite que cobre as cartas
        slot = [CCSprite spriteWithFile:@"SlotLocation.png"];
        slot.position = ccp(defaultCardX,defaultCardY);
        [self addChild:slot];
        
        
        
        //CRIA O "ENTERFRAME"
        // schedule a repeating callback on every frame
        [self schedule:@selector(nextFrame:)];
        
        //define a velocidade inicial das colunas
        speedColuna1 = 0;
        
        
        
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
    
    //decide entre GIRO ou SNAP
    if (speedColuna1 > 0) {
        //GIRO
        //atualiza a nova posição das cartas (aplica a velocidade)
        card1.position = ccp(card1.position.x, card1.position.y - speedColuna1);
        card2.position = ccp(card2.position.x, card2.position.y - speedColuna1);
        card3.position = ccp(card3.position.x, card3.position.y - speedColuna1);
            
        //aplica o atrito
        speedColuna1 *= .98;
        
        //reseta a flag
        snapTargetsDefinedColuna1 = NO;
    } else {
//        //SNAP
//        
//        //identifica quem está mais perto
//        float d1 = card1.position.y - defaultCardY;
//        float d2 = card2.position.y - defaultCardY;
//        float d3 = card3.position.y - defaultCardY;
//        
//        //define os alvos
//        if(!snapTargetsDefinedColuna1){
//            if(abs(d1)<cardHeight/2){
//                //card 1 é a mais próxima
//                card1_yAlvo = defaultCardY;
//                //define o alvo das outras
//                card2_yAlvo = card2.position.y - d1;
//                card3_yAlvo = card3.position.y - d1;
//                NSLog(@"Dark Ripper (%f, %f, %f)", d1, d2, d3);
//            } else if(abs(d2)<cardHeight/2){
//                //card 2 é a mais próxima
//                card2_yAlvo = defaultCardY;
//                //define o alvo das outras
//                card1_yAlvo = card1.position.y - d2;
//                card3_yAlvo = card3.position.y - d2;
//                NSLog(@"Forest Brute (%f, %f, %f)", d1, d2, d3);
//            } else if(abs(d3)<cardHeight/2){
//                //card 3 é a mais próxima
//                card3_yAlvo = defaultCardY;
//                //define o alvo das outras
//                card2_yAlvo = card2.position.y - d3;
//                card1_yAlvo = card1.position.y - d3;
//                NSLog(@"Tesla (%f, %f, %f)", d1, d2, d3);
//            }
//            
//            //avisa que já calculou
//            snapTargetsDefinedColuna1 = YES;
//        }
//        
//        //aplica as posições
//        if (abs(card1.position.y - card1_yAlvo) > 1) {
//            card1.position = ccp(card1.position.x, card1.position.y + (card1_yAlvo - card1.position.y)/5);
//            card2.position = ccp(card2.position.x, card2.position.y + (card2_yAlvo - card2.position.y)/5);
//            card3.position = ccp(card3.position.x, card2.position.y + (card3_yAlvo - card3.position.y)/5);
//        } else {
//            card1.position = ccp(card1.position.x, card1_yAlvo);
//            card2.position = ccp(card2.position.x, card2_yAlvo);
//            card3.position = ccp(card3.position.x, card3_yAlvo);
//        }
    }

    //mantém a carta pronta para aparecer no lugar certo (quando se move para baixo)
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

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //define um novo valor para a velocidade das colunas
    speedColuna1 = 50 + CCRANDOM_0_1() * 50;
    NSLog(@"speed: %f", speedColuna1);
    
//	CGPoint location = [self convertTouchToNodeSpace: touch];
    //seta um novo alvo
//    cocosGuyNewLocation = location;
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
