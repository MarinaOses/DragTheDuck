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
@synthesize sceneObjects = _sceneObjects;
@synthesize scoreBoard = _scoreBoard;
@synthesize takenLeavesButton = _takenLeavesButton;

- (id)initWithSceneController:(MGSceneController *)scene_controller TimeController:(MGTimeController *)time_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        _sceneObjectDestroyer = [[MGSceneObjectDestroyer alloc] init];
        _sceneObjects = [[NSMutableArray alloc] init];
        _scoreBoard = [[MGScoreBoard alloc] init];
        _takenLeavesButton = [[MGTakenLeavesButton alloc] initWithSceneController:scene_controller 
                            Translation:MGPointMake(-210.0, -130.0, 0.0) 
                            Rotation:MGPointZero() 
                            Scale:MGPointMake(50.0, 50.0, 1.0) 
                            scoreBoard:self.scoreBoard];
        self.timeController = time_controller;
        timedMultipleObjectGeneratorForDucks = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:DUCKS WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer takenLeavesButton:self.takenLeavesButton] TimeController:time_controller];
        timedMultipleObjectGeneratorForBirds = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:BIRDS WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer takenLeavesButton:self.takenLeavesButton] TimeController:time_controller];
        timedMultipleObjectGeneratorForLeaves = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:LEAVES WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer takenLeavesButton:self.takenLeavesButton] TimeController:time_controller];
        timedMultipleObjectGeneratorForBees = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:BEES WithSceneController:scene_controller SceneObjectDestroyer:self.sceneObjectDestroyer takenLeavesButton:self.takenLeavesButton] TimeController:time_controller];
    }
    return self;
}

- (void)loadPlayState {
    [self.sceneObjects addObject:self.takenLeavesButton];
    [self.sceneObjects addObject:self.takenLeavesButton.takenLeavesButtonShowerLayer];
    [timedMultipleObjectGeneratorForDucks loadNewObjectsWaveToAdd];
    [timedMultipleObjectGeneratorForBirds loadNewObjectsWaveToAdd];
    //[timedMultipleObjectGeneratorForLeaves loadNewObjectsWaveToAdd];
}

- (void)startPlayState {
    [self.timeController start];
    [timedMultipleObjectGeneratorForDucks setNextTimeToAppear];
    [timedMultipleObjectGeneratorForBirds setNextTimeToAppear];
    [timedMultipleObjectGeneratorForLeaves setNextTimeToAppear];
    [timedMultipleObjectGeneratorForBees setNextTimeToAppear];
}

- (void)updatePlayState {
    if ([[timedMultipleObjectGeneratorForDucks objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForDucks objectsToAdd]];
        [timedMultipleObjectGeneratorForDucks clearObjectsToAdd];
    }
    if ([[timedMultipleObjectGeneratorForBirds objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForBirds objectsToAdd]];
        [timedMultipleObjectGeneratorForBirds clearObjectsToAdd];
    }
    
    if ([[timedMultipleObjectGeneratorForLeaves objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForLeaves objectsToAdd]];
        [timedMultipleObjectGeneratorForLeaves clearObjectsToAdd];
    }
    
    if ([[timedMultipleObjectGeneratorForBees objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForBees objectsToAdd]];
        [timedMultipleObjectGeneratorForBees clearObjectsToAdd];
    }
    [self.sceneObjectDestroyer destroyFrom:self.sceneObjects];
    [self.sceneObjects makeObjectsPerformSelector:@selector(update)];    
}


- (void)renderPlayState {
    [self.sceneObjects makeObjectsPerformSelector:@selector(render)];    
    //NSLog(@"sceneObjects count = %d",[sceneObjects count]);
}

- (void)stopPlayState {
    [self.timeController stop];
}

- (void)dealloc {
    [timedMultipleObjectGeneratorForDucks release];
    [timedMultipleObjectGeneratorForBirds release];
    [timedMultipleObjectGeneratorForLeaves release];
    [timedMultipleObjectGeneratorForBees release];
    [_timeController release];
    [_sceneObjectDestroyer release];
    [_sceneObjects release];
    [_scoreBoard release];
    [_takenLeavesButton release];
    [super dealloc];
}


@end
