//
//  GameMark.h
//  MaoWar
//
//  Created by panda zheng on 13-6-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameMark : CCNode {
    CCArray *bits;
    int mark;
    CCTexture2D *ui;
}

- (void) addnumber: (int) var;

@end
