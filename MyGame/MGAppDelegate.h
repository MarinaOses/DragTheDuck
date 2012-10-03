//
//  PRAppDelegate.h
//  MyGame
//
//  Created by Marina Osés Merino on 16/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGStateManager.h"
#import "MGOpenALSoundController.h"

@interface MGAppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *_window;
    MGStateManager *_stateManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MGStateManager *stateManager;

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window;

@end
