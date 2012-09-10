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
@synthesize sceneObjectDestroyerForState = _sceneObjectDestroyerForState;



- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.sceneControllerForState = scene_controller;
        _sceneObjects = [[NSMutableArray alloc] init];
        _sceneObjectDestroyerForState = [[MGSceneObjectDestroyer alloc] init];
        [[MGOpenALSoundController sharedSoundController] setSoundCallBackDelegate:self];
    }
    return self;
}

- (void)soundDidFinishPlaying:(NSNumber *)source_number {
    [self.sceneObjects makeObjectsPerformSelector:@selector(soundDidFinishPlaying:) withObject:source_number];
}


- (void)loadState {
    
}

- (void)startState {
    
}

- (void)updateState {
    [self.sceneObjectDestroyerForState destroyFrom:self.sceneObjects];
    [self.sceneObjects makeObjectsPerformSelector:@selector(update)];
    
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
    [_sceneObjectDestroyerForState release];
    [super dealloc];
}
@end
