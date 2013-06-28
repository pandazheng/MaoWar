//
//  GameAbout.m
//  MaoWar
//
//  Created by panda zheng on 13-6-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameAbout.h"
#import "GameMenu.h"

@implementation GameAbout

+ (CCScene*) scene
{
    CCScene *scene = [CCScene node];
    GameAbout *layer = [GameAbout node];
    [scene addChild:layer];
    return scene;
}

- (id) init
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
        [bgstar setPosition:ccp(size.width/3*1,0)];
        [self addChild:bgstar z:1 tag:1];
        
        //初始化关于框
        CCSprite *kuang = [CCSprite spriteWithFile:@"tb.png"];
        [kuang setScale:0.5];
        [kuang setPosition:ccp(size.width/2,size.height/2)];
        [self addChild:kuang z:2 tag:2];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"name:meow war\n\nprogram:pandazheng\n\nart design:pandazheng\n\nweb:pandazheng.blog.163.com\n\npowered by cocos2d" fontName:@"Marker Felt" fontSize:40];
        [label setAnchorPoint:ccp(0,1)];
        [label setColor:ccc3(200, 200, 200)];
        [label setPosition:ccp(65,600)];
        [kuang addChild:label];
        
        //初始化关于标题
        CCSprite *abouttitle = [CCSprite spriteWithFile:@"about.png"];
        [abouttitle setScale:0.5];
        [abouttitle setPosition:ccp(size.width/2,size.height - 20)];
        [self addChild:abouttitle z:3 tag:3];
        
        //初始化返回按钮
        CCMenuItemImage *back = [CCMenuItemImage itemWithNormalImage:@"backA.png" selectedImage:@"backB.png" target:self selector:@selector(menuBackCallback:)];
        [back setScale:0.5];
        [back setPosition:ccp(size.width - 20,size.height - 20)];
        [back setIsEnabled:NO];
        
        CCMenu *mainmenu = [CCMenu menuWithItems:back, nil];
        [mainmenu setPosition:ccp(0,0)];
        [self addChild:mainmenu z:3 tag:4];
    }
    
    return self;
}

- (void) menuBackCallback:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:0.5 scene:[GameMenu scene]]];
}

- (void) onEnter
{
    [super onEnter];
    CCNode *mainmenu = (CCNode*)[self getChildByTag:4];
    CCArray *temp = [mainmenu children];
    [(CCMenuItemImage*)[temp objectAtIndex:0] setIsEnabled:YES];
}

- (void) onExit
{
    [super onExit];
}

@end
