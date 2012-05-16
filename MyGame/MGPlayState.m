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
        _birdDestroyer = [[MGSceneObjectDestroyer alloc] init];
        timedMultipleBirdGenerator = [[MGTimedMultipleBirdGenerator alloc] initWithSceneController:scene_controller SceneObjectDestroyer:self.birdDestroyer];
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
    [self.birdDestroyer destroyFrom:sceneObjects];
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
