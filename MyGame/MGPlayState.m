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
@synthesize timeController = _timeController;

- (id)initWithSceneController:(MGSceneController *)scene_controller TimeController:(MGTimeController *)time_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        _sceneObjectDestroyer = [[MGSceneObjectDestroyer alloc] init];
        sceneObjects = [[NSMutableArray alloc] init];
        self.timeController = time_controller;
        timedMultipleObjectGeneratorForDucks = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:0 WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer] TimeController:time_controller];
        timedMultipleObjectGeneratorForBirds = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:1 WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer ] TimeController:time_controller];
        timedMultipleObjectGeneratorForLeaves = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:2 WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer ] TimeController:time_controller];
    }
    return self;
}

- (void)loadPlayState {
    [timedMultipleObjectGeneratorForDucks loadNewObjectsWaveToAdd];
    [timedMultipleObjectGeneratorForBirds loadNewObjectsWaveToAdd];
    //[timedMultipleObjectGeneratorForLeaves loadNewObjectsWaveToAdd];
}

- (void)startPlayState {
    [self.timeController start];
    [timedMultipleObjectGeneratorForDucks setNextTimeToAppear];
    [timedMultipleObjectGeneratorForBirds setNextTimeToAppear];
    [timedMultipleObjectGeneratorForLeaves setNextTimeToAppear];
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
    
    if ([[timedMultipleObjectGeneratorForLeaves objectsToAdd] count] > 0) {
        [sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForLeaves objectsToAdd]];
        [timedMultipleObjectGeneratorForLeaves clearObjectsToAdd];
    }

    [sceneObjects makeObjectsPerformSelector:@selector(update)];    
}


- (void)renderPlayState {
    [sceneObjects makeObjectsPerformSelector:@selector(render)];    
    [self.sceneObjectDestroyer destroyFrom:sceneObjects];
    //NSLog(@"sceneObjects count = %d",[sceneObjects count]);
}

- (void)stopPlayState {
    [self.timeController stop];
}

- (void)dealloc {
    [timedMultipleObjectGeneratorForDucks release];
    [timedMultipleObjectGeneratorForBirds release];
    [timedMultipleObjectGeneratorForLeaves release];
    [_timeController release];
    [_sceneObjectDestroyer release];
    [sceneObjects release];
    [super dealloc];
}


@end
