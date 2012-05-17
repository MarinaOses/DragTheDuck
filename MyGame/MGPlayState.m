//
//  MGPlayState.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGPlayState.h"

@implementation MGPlayState
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        _sceneObjectDestroyer = [[MGSceneObjectDestroyer alloc] init];
        sceneObjects = [[NSMutableArray alloc] init];
        timedMultipleObjectGeneratorForDucks = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:0 WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer]];
        timedMultipleObjectGeneratorForBirds = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:1 WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer]];
    }
    return self;
}

- (void)loadPlayState {
    [timedMultipleObjectGeneratorForDucks loadNewObjectsWaveToAdd];
    [timedMultipleObjectGeneratorForBirds loadNewObjectsWaveToAdd];
}

- (void)startPlayState {
    [timedMultipleObjectGeneratorForDucks startNextTimer];
    [timedMultipleObjectGeneratorForBirds startNextTimer];
}

- (void)updatePlayState {
    if ([[timedMultipleObjectGeneratorForDucks objectsToAdd] count] > 0) {
        [sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForDucks objectsToAdd]];
        [timedMultipleObjectGeneratorForDucks clearObjectsToAdd];
    }
    if ([[timedMultipleObjectGeneratorForBirds objectsToAdd] count] > 0) {
        [sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForBirds objectsToAdd]];
        [timedMultipleObjectGeneratorForBirds clearObjectsToAdd];
    }

    [sceneObjects makeObjectsPerformSelector:@selector(update)];    
}


- (void)renderPlayState {
    [sceneObjects makeObjectsPerformSelector:@selector(render)];    
    [self.sceneObjectDestroyer destroyFrom:sceneObjects];
    NSLog(@"sceneObjects count = %d",[sceneObjects count]);
}

- (void)stopPlayState {
    [timedMultipleObjectGeneratorForDucks stopGeneratorTimer];
    [timedMultipleObjectGeneratorForBirds stopGeneratorTimer];
}

- (void)dealloc {
    [timedMultipleObjectGeneratorForDucks release];
    [timedMultipleObjectGeneratorForBirds release];
    [_sceneObjectDestroyer release];
    [sceneObjects release];
    [super dealloc];
}


@end
