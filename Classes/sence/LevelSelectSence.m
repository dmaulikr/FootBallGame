//
//  LevelSelectSence.m
//  Helicopter
//
//  Created by admin on 4/26/11.
//  Copyright 2011 _ Center_. All rights reserved.
//

#import "LevelSelectSence.h"
#import "GameSence.h"
#import "MenuSence.h"

@implementation LevelSelectSence
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelSelectSence *layer = [LevelSelectSence node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	
	if( (self=[super init] )) {
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		background = [CCSprite spriteWithFile:@"levelselect_background.png"];
		background.position = ccp(size.width/2, size.height/2);
		[self addChild:background];
		
		//easy button
		CCMenuItemImage *easyitem = [CCMenuItemImage itemFromNormalImage:@"easy_button_n.png" selectedImage:@"easy_button_d.png" target:self selector:@selector(easyGame:)];
		easy = [CCMenu menuWithItems: easyitem, nil];
		easy.position = ccp(size.width/2, size.height*6/10);		
		[self addChild:easy];
		
		easyitem.position = ccp(easyitem.position.x, easyitem.position.y-100);
		id dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,100)];
		id easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[easyitem runAction:easeDrop];
		
		//medium button
		CCMenuItemImage *mediumitem = [CCMenuItemImage itemFromNormalImage:@"medium_button_n.png" selectedImage:@"medium_button_d.png" target:self selector:@selector(mediumGame:)];
		medium = [CCMenu menuWithItems: mediumitem, nil];
		medium.position = ccp(size.width/2, size.height*4.5/10);		
		[self addChild:medium];
		
		mediumitem.position = ccp(mediumitem.position.x, mediumitem.position.y-200);
		dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,200)];
		easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[mediumitem runAction:easeDrop];
		
		//hard button
		CCMenuItemImage *harditem = [CCMenuItemImage itemFromNormalImage:@"hard_button_n.png" selectedImage:@"hard_button_d.png" target:self selector:@selector(hardGame:)];
		hard = [CCMenu menuWithItems: harditem, nil];
		hard.position = ccp(size.width/2, size.height*3/10);		
		[self addChild:hard];
		
		harditem.position = ccp(harditem.position.x, harditem.position.y-300);
		dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,300)];
		easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[harditem runAction:easeDrop];
		
		//mainmenu button
		CCMenuItemImage *mainitem = [CCMenuItemImage itemFromNormalImage:@"mainmenu_n.png" selectedImage:@"mainmenu_d.png" target:self selector:@selector(mainMenu:)];
		main = [CCMenu menuWithItems: mainitem, nil];
		main.position = ccp(size.width/2, size.height/7);		
		[self addChild:main];
		
		mainitem.position = ccp(mainitem.position.x, mainitem.position.y-400);
		dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,400)];
		easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[mainitem runAction:easeDrop];		
		
		NSBundle *mainBundle = [NSBundle mainBundle];
		click = [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"click" ofType:@"caf"]];
	
		ball = [CCSprite spriteWithFile:@"title_ball.png"];
		ball.position = ccp(size.width*4.1/5, size.height/6.5);
		[self addChild:ball];
		
		title = [CCSprite spriteWithFile:@"title_text.png"];
		title.position = ccp(size.width*4/5, size.height/8);
		[self addChild:title];
		
		[self schedule:@selector(ball_draw:) interval:0.05];
	}
	return self;
}

- (void) easyGame: (id) sender
{
	[click play];
	HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
	appDelegate.level = 1;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[GameSence scene]]] ;
}

- (void) mediumGame: (id) sender
{
	[click play];
	HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
	appDelegate.level = 2;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[GameSence scene]]] ;
}

- (void) hardGame: (id) sender
{
	[click play];
	HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
	appDelegate.level = 3;
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[GameSence scene]]] ;
}

- (void) mainMenu: (id) sender
{
	[click play];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[MenuSence scene]]] ;
}

-(void) ball_draw: (ccTime) dt
{
	ball.rotation += 5;
}

- (void) dealloc
{
	[click release];
	[background removeFromParentAndCleanup:TRUE];
	[easy removeFromParentAndCleanup:TRUE];
	[medium removeFromParentAndCleanup:TRUE];
	[hard removeFromParentAndCleanup:TRUE];
	[main removeFromParentAndCleanup:TRUE];
	
	[ball removeFromParentAndCleanup:TRUE];
	[title removeFromParentAndCleanup:TRUE];
	
	[super dealloc];
}


@end
