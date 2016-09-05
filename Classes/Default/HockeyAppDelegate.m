//
//  HockeyAppDelegate.m
//  Hockey
//
//  Created by YunCholHo on 3/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"

#import "HockeyAppDelegate.h"
#import "GameConfig.h"
#import "HelloWorldScene.h"
#import "RootViewController.h"
#import "LogoSence.h"
#import "LBViewController.h"

@implementation HockeyAppDelegate

@synthesize window;
@synthesize gameCenterManager, currentLeaderBoard;
@synthesize num,level;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController

//	CC_ENABLE_DEFAULT_GL_STATES();
//	CCDirector *director = [CCDirector sharedDirector];
//	CGSize size = [director winSize];
//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
//	sprite.position = ccp(size.width/2, size.height/2);
//	sprite.rotation = -90;
//	[sprite visit];
//	[[director openGLView] swapBuffers];
//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
	//#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	//#else
	//	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
	//#endif
	
	[director setAnimationInterval:1.0/30];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	
	// Removes the startup flicker
	[self removeStartupFlicker];
	
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [LogoSence scene]];		
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)initGameCenter {
	if(gcviewController != nil)
		return;
	gcviewController = [GCViewController alloc];
	self.currentLeaderBoard = kEasyLeaderboardID;
	if ([GameCenterManager isGameCenterAvailable])
	{
		self.gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
		[self.gameCenterManager setDelegate:self];
		[self.gameCenterManager authenticateLocalUser];
	}
}

- (void) addOne{
	[self performSelector:@selector(submitScore) withObject:nil afterDelay:0.2];
}

- (void)submitScore:(int)nScore{
	
	if (level == 1) 
	{
		self.currentLeaderBoard = kEasyLeaderboardID;
	}
	if (level == 2) 
	{
		self.currentLeaderBoard = kMediumLeaderboardID;
	}
	if (level == 3) 
	{
		self.currentLeaderBoard = kHardLeaderboardID;
	}
	
	if(nScore>0){
		[self initGameCenter];
		[self.gameCenterManager reportScore: nScore forCategory: self.currentLeaderBoard];
	}
}

- (void) showLeaderboard {
	LBViewController *leaderboardController = [[LBViewController alloc] init];
	if (leaderboardController != NULL) {
		leaderboardController.category = self.currentLeaderBoard;
		leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
		leaderboardController.leaderboardDelegate = self; 
		[gcviewController presentModalViewController: leaderboardController animated: YES];
	}
}

- (void) showAchievements{
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	if (achievements != NULL){
		achievements.achievementDelegate = self;
		[gcviewController presentModalViewController: achievements animated: YES];
	}
}


- (void)abrirLDB{
	
	if (level == 1) 
	{
		self.currentLeaderBoard = kEasyLeaderboardID;
	}
	if (level == 2) 
	{
		self.currentLeaderBoard = kMediumLeaderboardID;
	}
	if (level == 3) 
	{
		self.currentLeaderBoard = kHardLeaderboardID;
	}
	
	if([GameCenterManager isGameCenterAvailable])
	{
		[self initGameCenter];
		[gcviewController.view setHidden:YES];
		[self.window addSubview:gcviewController.view];
		[self showLeaderboard];
	}
	else 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"Gamecenter is not available in your iOS version" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
}

- (void)abrirACHV{
	if([GameCenterManager isGameCenterAvailable])
	{
		[self initGameCenter];
		[gcviewController.view setHidden:YES];
		//	[self.window addSubview:gcviewController.view];
		[self showAchievements];
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"Gamecenter is not available in your iOS version" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewcontroller;{
	[viewcontroller dismissModalViewControllerAnimated: YES];
	//	[gcviewController.view removeFromSuperview];
	//	[gcviewController.view setHidden:YES];
}


- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewcontroller{
	[viewcontroller dismissModalViewControllerAnimated: YES];
	//	[gcviewController.view removeFromSuperview];
	//	[gcviewController.view setHidden:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
