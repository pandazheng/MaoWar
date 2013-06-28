//
//  GameMenu.m
//  MaoWar
//
//  Created by panda zheng on 13-6-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameMenu.h"
#import "SimpleAudioEngine.h"
#import "GameAbout.h"
#import "GameMain.h"


@implementation GameMenu

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    GameMenu *layer = [GameMenu node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //初始化背景
        CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
        [bg setScale:0.5];
        [bg setPosition:ccp(size.width/2,size.height/2)];
        [self addChild:bg z:0 tag:0];
        
        //初始化星球
        CCSprite *bgstar = [CCSprite spriteWithFile:@"moon.png"];
        [bgstar setAnchorPoint:ccp(0.5,0)];
        [bgstar setScale:0.5];
        [bgstar setPosition:ccp(size.width/3*2,0)];
        [self addChild:bgstar z:1 tag:1];
        
        //初始化标题
        CCNode *title = [CCNode node];
        [title setContentSize:CGSizeMake(size.width - 40, 50)];
        CCSprite *ptmLabel = [CCSprite spriteWithFile:@"meowstar.png"];
        [ptmLabel setScale:0.5];
        [ptmLabel setPosition:ccp(0,30)];
        [title addChild:ptmLabel];
        CCSprite *ptbLabel = [CCSprite spriteWithFile:@"battle.png"];
        [ptbLabel setScale:0.5];
        [ptbLabel setPosition:ccp(0,-30)];
        [title addChild:ptbLabel];
        [title setPosition:ccp(size.width/2,size.height - 80)];
        [self addChild:title z:2 tag:2];
        
        //初始化按钮
        CCMenuItemImage *newGameItem = [CCMenuItemImage itemWithNormalImage:@"newgameA.png" selectedImage:@"newgameB.png" target:self selector:@selector(menuNewGameCallback:)];
        [newGameItem setScale:0.5];
        [newGameItem setPosition:ccp(size.width/2,size.height/2 - 20)];
        [newGameItem setIsEnabled:NO];
        
        CCMenuItemImage *continueItem = [CCMenuItemImage itemWithNormalImage:@"continueA.png" selectedImage:@"continueB.png" target:self selector:@selector(menuContinueCallback:)];
        [continueItem setScale:0.5];
        [continueItem setPosition:ccp(size.width/2,size.height/2 - 80)];
        [continueItem setIsEnabled:NO];
        
        CCMenuItemImage *aboutItem = [CCMenuItemImage itemWithNormalImage:@"aboutA.png" selectedImage:@"aboutB.png" target:self selector:@selector(menuAboutCallback:)];
        [aboutItem setScale:0.5];
        [aboutItem setPosition:ccp(size.width/2,size.height/2 - 140)];
        [aboutItem setIsEnabled:NO];
        
        soundItem = [CCMenuItemImage itemWithNormalImage:@"sound-on-A.png" selectedImage:@"sound-on-B.png" target:self selector:@selector(menuSoundCallback:)];
        [soundItem setScale:0.5];
        [soundItem setPosition:ccp(40,40)];
        [soundItem setIsEnabled:NO];
        
        //使用按钮创建菜单
        CCMenu *mainmenu = [CCMenu menuWithItems:newGameItem,continueItem,aboutItem,soundItem, nil];
        [mainmenu setPosition:ccp(0,0)];
        [self addChild:mainmenu z:1 tag:3];
        
        //初始化声音部分
        issound = YES;      //是否开启声音参数
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"background.mp3"];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background.mp3" loop:YES];
    }
    
    return self;
}

- (void) onEnter
{
    [super onEnter];
    //菜单进入后，菜单项点击有效
    CCNode *mainmenu = (CCNode*)[self getChildByTag:3];
    CCArray *temp = [mainmenu children];
    for (int i = 0 ; i < [temp count] ; i++)
    {
        [(CCMenuItemImage*)[temp objectAtIndex:i] setIsEnabled:YES];
    }
}

- (void) onExit
{
    [super onExit];
}

- (void) menuNewGameCallback:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:[GameMain scene]]];
}

- (void) menuContinueCallback:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:[GameMain scene]]];
}

- (void) menuAboutCallback:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:[GameAbout scene]]];
}

- (void) menuSoundCallback:(id)sender
{
    if (!issound)
    {
        [soundItem setNormalImage:[CCSprite spriteWithFile:@"sound-on-A.png"]];
        [soundItem setDisabledImage:[CCSprite spriteWithFile:@"sound-on-B.png"]];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background.mp3" loop:YES];
        issound = YES;
    }
    else
    {
        [soundItem setNormalImage:[CCSprite spriteWithFile:@"sound-off-A.png"]];
        [soundItem setDisabledImage:[CCSprite spriteWithFile:@"sound-off-B.png"]];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        issound = NO;
    }
}

@end
