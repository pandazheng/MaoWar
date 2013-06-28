//
//  GameObjEnemy.h
//  MaoWar
//
//  Created by panda zheng on 13-6-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameObjEnemy : CCNode {
    CCSprite *boom;
    CCSprite *mainbody;
    short type;
    bool islife;
}

- (void) releasebullet;
- (void) movestart;
- (void) restart;
- (void) setdie;
- (void) setType: (short) var;
- (bool) getlife;

@end
