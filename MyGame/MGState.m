//
//  MGState.m
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"

#import "MGSceneController.h"
#import "MGStateManager.h"

@implementation MGState

@synthesize sceneControllerForState = _sceneControllerForState;
@synthesize stateManager = _stateManager;



- (id)initWithSceneController:(MGSceneController *)scene_controller andWithStateManager:(MGStateManager *)state_manager {
    self = [super init];
    if (self) {
        self.sceneControllerForState = scene_controller;
        self.stateManager = state_manager;
    }
    return self;
}

- (void)dealloc {
    [_sceneControllerForState release];
    [_stateManager release];
    [super dealloc];
}
@end
