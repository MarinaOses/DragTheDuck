//
//  MGPlayState.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"
#import "MGTimedMultipleObjectGenerator.h"
#import "MGSceneObjectDestroyer.h"

@interface MGPlayState : MGState {
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForDucks;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForBirds;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForLeaves;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGTimeController *_timeController;
    NSMutableArray *sceneObjects;
}

@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGTimeController *timeController;


- (id)initWithSceneController:(MGSceneController *)scene_controller TimeController:(MGTimeController *)time_controller;
- (void)loadPlayState;
- (void)startPlayState;
- (void)updatePlayState;
- (void)renderPlayState;
- (void)stopPlayState;

@end
