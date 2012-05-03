//
//  PRAppDelegate.m
//  MyGame
//
//  Created by Marina Osés Merino on 16/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGSceneController.h"
#import "MGInputViewController.h"

@implementation MGAppDelegate

@synthesize window = _window;



//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
//    return YES;
//}

-(void) applicationDidFinishLaunching:(UIApplication *)application {
    //Se crea un objeto sceneController 
    MGSceneController *sceneController = [[MGSceneController alloc] init];
    
    //Y su respectivo inputController
    MGInputViewController *anInputViewController = [[MGInputViewController alloc] initWithNibName:nil bundle:nil];
    sceneController.inputViewController = anInputViewController;
    [anInputViewController release];
    
    //Se crea el EAGLView principal con las mismas dimensiones que window
    EAGLView *glView = [[EAGLView alloc] initWithFrame:self.window.bounds];
    sceneController.inputViewController.view = glView;
    sceneController.openGLView = glView;
    [glView release];
    
    //Se crea el manager de estados del juego
    MGStateManager *managerToAssign = [[MGStateManager alloc] initWithSceneController:sceneController];
    sceneController.stateManager = managerToAssign;
    [managerToAssign release];
    
    //Asignamos la vista creda como vista principal de window
    [self.window addSubview:sceneController.inputViewController.view];
    //Por conveniencia. Para hacer visible el window y crearle un key
    [self.window makeKeyAndVisible];
    
    //Empezar el juego
    [sceneController loadScene];
    [sceneController startScene];
                        
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //[[UIApplication sharedApplication] terminate];
    //exit(0)
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}


@end
