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
@synthesize sceneObjects = _sceneObjects;



- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.sceneControllerForState = scene_controller;
        _sceneObjects = [[NSMutableArray alloc] init];
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
    [self.sceneObjects makeObjectsPerformSelector:@selector(render)];
}

- (void)stopState {
    [self.sceneControllerForState stopAnimation];
}

- (void)dealloc {
    [_sceneControllerForState release];
    [_sceneObjects release];
    [super dealloc];
}
@end
