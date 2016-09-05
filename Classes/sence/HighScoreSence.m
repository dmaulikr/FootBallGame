//
//  HighScoreSence.m
//  Helicopter
//
//  Created by admin on 4/30/11.
//  Copyright 2011 _ Center_. All rights reserved.
//

#import "HighScoreSence.h"
#import "MenuSence.h"

@implementation HighScoreSence
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HighScoreSence *layer = [HighScoreSence node];
	
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
		
		background = [CCSprite spriteWithFile:@"highscore_background.png"];
		background.position = ccp(size.width/2, size.height/2);
		[self addChild:background];
				
		//mainmenu button
		CCMenuItemImage *mainitem = [CCMenuItemImage itemFromNormalImage:@"highscore_menu_n.png" selectedImage:@"highscore_menu_d.png" target:self selector:@selector(mainMenu:)];
		main = [CCMenu menuWithItems: mainitem, nil];
		main.position = ccp(size.width/2, size.height/5);		
		[self addChild:main];
		
		mainitem.position = ccp(mainitem.position.x, mainitem.position.y-100);
		id dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,100)];
		id easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
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
	[ball removeFromParentAndCleanup:TRUE];
	[title removeFromParentAndCleanup:TRUE];
	[background removeFromParentAndCleanup:TRUE];
	[self unschedule:@selector(ball_draw:)];
	
	[super dealloc];
}


@end
