//
//  HighScoreSence.h
//  Helicopter
//
//  Created by admin on 4/30/11.
//  Copyright 2011 _ Center_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SoundFx.h"

@interface HighScoreSence : CCLayer {
	CCMenu *main;
	CCSprite *background;
	SoundFx *click;
	
	CCSprite *ball;
	CCSprite *title;
	
}

+ (id) scene;
-(void) mainMenu: (id) sender;
-(void) ball_draw: (ccTime) dt;

@end
