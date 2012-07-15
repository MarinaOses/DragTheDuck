//
//  MGState.m
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"

#import "MGSceneController.h"

@implementation MGState

@synthesize sceneControllerForState = _sceneControllerForState;



- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.sceneControllerForState = scene_controller;
    }
    return self;
}


- (void)loadState {
    
}

- (void)startState {
    
}

- (void)updateState {
    
}

- (void)renderState {
    
}

- (void)stopState {
    [self.sceneControllerForState stopAnimation];
}

- (void)dealloc {
    [_sceneControllerForState release];
    [super dealloc];
}
@end
