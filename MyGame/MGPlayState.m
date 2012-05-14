//
//  MGPlayState.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGPlayState.h"

@implementation MGPlayState
@synthesize birdDestroyer = _birdDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        timedMultipleBirdGenerator = [[MGTimedMultipleBirdGenerator alloc] initWithSceneController:scene_controller];
        _birdDestroyer = [[MGBirdDestroyer alloc] init];
        sceneObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadPlayState {
    [timedMultipleBirdGenerator loadNewBirdsWaveToAdd];
}

- (void)startPlayState {
    [timedMultipleBirdGenerator startNextTimer];
}

- (void)updatePlayState {
    if ([[timedMultipleBirdGenerator birdsToAdd] count] > 0) {
        [sceneObjects addObjectsFromArray:[timedMultipleBirdGenerator birdsToAdd]];
        [timedMultipleBirdGenerator clearBirdsToAdd];
    }
    [sceneObjects makeObjectsPerformSelector:@selector(update)];    
}


- (void)renderPlayState {
    [sceneObjects makeObjectsPerformSelector:@selector(render)];    
    if ([[self.birdDestroyer birdsToRemove] count] > 0) {
        [sceneObjects removeObjectsInArray:[self.birdDestroyer birdsToRemove]];
        [self.birdDestroyer clearBirdsToRemove];
    }
    NSLog(@"sceneObjects count = %d",[sceneObjects count]);
}

- (void)stopPlayState {
    [timedMultipleBirdGenerator stopGeneratorTimer];
}

- (void)dealloc {
    [timedMultipleBirdGenerator release];
    [_birdDestroyer release];
    [sceneObjects release];
    [super dealloc];
}


@end
