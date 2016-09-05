//
//  LevelSelectSence.h
//  Helicopter
//
//  Created by admin on 4/26/11.
//  Copyright 2011 _ Center_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HockeyAppDelegate.h"
#import "SoundFx.h"

@interface LevelSelectSence : CCLayer {
	CCMenu *easy;
	CCMenu *medium;
	CCMenu *hard;
	CCMenu *main;
	CCSprite *background;
	
	CCSprite *ball;
	CCSprite *title;
	
	SoundFx *click;
}

+ (id) scene;
-(void) easyGame: (id) sender;
-(void) mediumGame: (id) sender;
-(void) hardGame: (id) sender;
-(void) mainMenu: (id) sender;

-(void) ball_draw: (ccTime) dt;

@end
