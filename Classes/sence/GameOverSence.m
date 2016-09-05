//
//  GameOverSence.m
//  Hockey
//
//  Created by  on 3/10/11.
//  Copyright 2011 . All rights reserved.
//

#import "GameOverSence.h"
#import "MenuSence.h"
#import "HockeyAppDelegate.h"
#import "GameSence.h"


@implementation GameOverSence

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverSence *layer = [GameOverSence node];
	
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
		
		NSBundle *mainBundle = [NSBundle mainBundle];
		people= [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"people2" ofType:@"caf"]];
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		scaleFactor=1;
		HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			scaleFactor = 2.3;
		}
		else {
			scaleFactor = 1;
		}

		//background
		CCSprite *background;
		if (appDelegate.num <= 5) {//game over
			background = [CCSprite spriteWithFile:@"gameover.png"];
		}
		else {// game clear
			background = [CCSprite spriteWithFile:@"gameclear.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
		[self addChild:background];
		
		star = [CCSprite spriteWithFile:@"star_1.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			star.position = ccp(size.width/2, size.height*3.6/4);
		}
		else {
			star.position = ccp(size.width/2, size.height*3.6/4);
		}
		[self addChild:star];
		
		[self schedule:@selector(star_move:) interval:0.25];
		
		if (appDelegate.num <= 5) {//game over
			star.visible = FALSE;
		}
		else {
			//game clear
			star.visible = TRUE;
			[people play];
			[self schedule:@selector(people_sound:) interval:6];
		}

		//start button
		CCMenuItemImage *retryitem = [CCMenuItemImage itemFromNormalImage:@"retry_n.png" selectedImage:@"retry_d.png" target:self selector:@selector(retryGame:)];
		retry = [CCMenu menuWithItems: retryitem, nil];
		retry.position = ccp(size.width/6, size.height/4);		
		[self addChild:retry];
		
		retryitem.position = ccp(retryitem.position.x-100, retryitem.position.y);
		id dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(100,0)];
		id easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[retryitem runAction:easeDrop];
		
		//mainmenu button
		CCMenuItemImage *mainitem = [CCMenuItemImage itemFromNormalImage:@"mainmenu_n.png" selectedImage:@"mainmenu_d.png" target:self selector:@selector(mainMenu:)];
		main = [CCMenu menuWithItems: mainitem, nil];
		main.position = ccp(size.width*5/6, size.height/4);		
		[self addChild:main];
		
		mainitem.position = ccp(mainitem.position.x+100, mainitem.position.y);
		dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(-100,0)];
		easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[mainitem runAction:easeDrop];
		
		//leaderboard button
		CCMenuItemImage *leaderboarditem = [CCMenuItemImage itemFromNormalImage:@"leaderboard_n.png" selectedImage:@"leaderboard_d.png" target:self selector:@selector(leaderBoard:)];
		leaderboard = [CCMenu menuWithItems: leaderboarditem, nil];
		leaderboard.position = ccp(size.width/2, size.height/4);		
		[self addChild:leaderboard];
		
		leaderboarditem.position = ccp(leaderboarditem.position.x, mainitem.position.y-100);
		dropTitle = [CCMoveBy actionWithDuration:1.5 position:ccp(0,100)];
		easeDrop = [CCEaseBounceOut actionWithAction:dropTitle];
		[leaderboarditem runAction:easeDrop];
		
		click = [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"click" ofType:@"caf"]];
		
		goalval = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",appDelegate.num] dimensions:CGSizeMake(60*scaleFactor, 60*scaleFactor) alignment:UITextAlignmentLeft fontName:@"Imagica" fontSize:9*scaleFactor];
		goalval.color = ccWHITE;
		if (appDelegate.num <= 5)//game over
		{
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				goalval.position = ccp(size.width*1.31/2,size.height*1.556/2);
			}
			else {
				goalval.position = ccp(size.width*1.3/2,size.height*1.56/2);
			}
		}
		else {//game clear
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				goalval.position = ccp(size.width*1.31/2,size.height*1.51/2);
			}
			else {
				goalval.position = ccp(size.width*1.3/2,size.height*1.5/2);
			}
		}

		[self addChild:goalval];
		//-----------------------submit value-----------------------
		[appDelegate submitScore:appDelegate.num];
	}
	return self;
}

- (void) retryGame: (id) sender
{
	[click play];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[GameSence scene]]] ;
}

- (void) mainMenu: (id) sender
{
	[click play];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[MenuSence scene]]] ;
}

-(void) leaderBoard: (id) sender
{
	[click play];
	HockeyAppDelegate* appDelegate = (HockeyAppDelegate*)[UIApplication sharedApplication].delegate;
	[appDelegate abrirLDB];
}

-(void) star_move: (ccTime) dt
{
	if (star_index < 5) 
	{
		star_index++;
	}
	else 
	{
		star_index = 1;
	}
	
	NSString *str = [NSString stringWithFormat:@"star_%d.png",star_index];
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: str];
	[star setTexture:texture];
	
	[star visit];
}

-(void) people_sound: (ccTime) dt
{
	[people play];
}
- (void) dealloc
{	
	[click release];
	[people release];
	[self unschedule:@selector(star_move:)];
	
	[super dealloc];
}

@end
