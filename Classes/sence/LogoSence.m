//
//  LogoSence.m
//  SpaceTravel
//


#import "LogoSence.h"
#import "MenuSence.h"
#import "SimpleAudioEngine.h"
#import "ParticleEffectSelfMade.h"

@interface LogoSence (PrivateMethods)
-(void) runEffect;
@end

@implementation LogoSence

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LogoSence *layer = [LogoSence node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		width=2;
		height=2;
	}
	else
	{
		width=1;
		height=1;
	}
	
	if( (self=[super init] )) {
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		challege = [CCSprite spriteWithFile:@"logo_challenge.png"];
		challege.position = ccp(size.width/2, size.height/2);
		[self addChild:challege];
		
		footballtitle = [CCSprite spriteWithFile:@"logo_football.png"];
		footballtitle.position = ccp(size.width*0.7/3, size.height*1.8/3);
		[self addChild:footballtitle];
		
		ball = [CCSprite spriteWithFile:@"logo_ball.png"];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			ball.position = ccp(size.width*0.665/3, size.height*1.455/3);
		}
		else
		{
			ball.position = ccp(size.width*0.73/3, size.height*1.465/3);
		}
		[self addChild:ball];
		
		
		NSBundle *mainBundle = [NSBundle mainBundle];
		keepermove_sound = [[SoundFx alloc] initWithContentsOfFile:[mainBundle pathForResource:@"keepermove" ofType:@"caf"]];	
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"main.wav" loop:YES];
		
	}
	return self;
}

- (void) onEnterTransitionDidFinish
{	
	[self schedule:@selector(loadmenu:) interval:3];	
	[self schedule:@selector(ball_draw:) interval:0.05];
	
	CGSize size = [[CCDirector sharedDirector] winSize];
	//keeper button
	CCMenuItemImage *keeperitem = [CCMenuItemImage itemFromNormalImage:@"logo_keeper2.png" selectedImage:@"logo_keeper2.png" target:self selector:@selector(keeper_action:)];
	keeper = [CCMenu menuWithItems: keeperitem, nil];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		keeper.position = ccp(size.width*2.28/3, size.height*1.3/3);
		[self addChild:keeper];
		keeperitem.position = ccp(keeperitem.position.x+400, keeperitem.position.y);
		id dropTitle = [CCMoveBy actionWithDuration:0.5 position:ccp(-400,0)];
		[keeperitem runAction:dropTitle];
	}
	else 
	{
		keeper.position = ccp(size.width*2.23/3, size.height*1.3/3);
		[self addChild:keeper];
		keeperitem.position = ccp(keeperitem.position.x+200, keeperitem.position.y);
		id dropTitle = [CCMoveBy actionWithDuration:0.5 position:ccp(-200,0)];
		[keeperitem runAction:dropTitle];
	}

	[keepermove_sound play];
}

-(void) loadmenu: (ccTime) dt{
	
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.7 scene:[MenuSence scene]]] ;

}

-(void) ball_draw: (ccTime) dt
{
	ball.rotation += 5;
}

-(void) keeper_action: (id) sender
{
}

-(void) runEffect
{
	// remove any previous particle FX
	[self removeChildByTag:1 cleanup:YES];
	
	CCParticleSystem* system;
	
	switch (particleType)
	{
		case ParticleTypeExplosion:
			system = [CCParticleExplosion node];
			break;
		case ParticleTypeFire:
			system = [CCParticleFire node];
			break;
		case ParticleTypeFireworks:
			system = [CCParticleFireworks node];
			break;
		case ParticleTypeFlower:
			system = [CCParticleFlower node];
			break;
		case ParticleTypeGalaxy:
			system = [CCParticleGalaxy node];
			break;
		case ParticleTypeMeteor:
			system = [CCParticleMeteor node];
			break;
		case ParticleTypeRain:
			system = [CCParticleRain node];
			break;
		case ParticleTypeSmoke:
			system = [CCParticleSmoke node];
			break;
		case ParticleTypeSnow:
			system = [CCParticleSnow node];
			break;
		case ParticleTypeSpiral:
			system = [CCParticleSpiral node];
			break;
		case ParticleTypeSun:
			system = [CCParticleSun node];
			break;
			
		default:
			// do nothing
			break;
	}
	
	[self addChild:system z:1 tag:1];
	
}


- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[challege removeFromParentAndCleanup:TRUE];
	[footballtitle removeFromParentAndCleanup:TRUE];
	[ball removeFromParentAndCleanup:TRUE];
	
	[self unschedule:@selector(ball_draw:)];
	[self unschedule:@selector(loadmenu:)];
	
	[keepermove_sound release];
	
	[super dealloc];
}

@end
