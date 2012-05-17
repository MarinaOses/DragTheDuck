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
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    NSMutableArray *sceneObjects;
}

@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;


- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadPlayState;
- (void)startPlayState;
- (void)updatePlayState;
- (void)renderPlayState;
- (void)stopPlayState;

@end
