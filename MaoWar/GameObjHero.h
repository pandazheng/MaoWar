//
//  GameObjHero.h
//  MaoWar
//
//  Created by panda zheng on 13-6-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameObjHero : CCNode <CCTargetedTouchDelegate> {
    CCSprite *lefthand;
    CCSprite *righthand;
    CGPoint offset;
    bool iscontrol;
}

- (void) releasebullet;
- (CGRect) rect;
- (bool) containsTouchLocation: (id) sender;


@end
