//
//  MGPlayState.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"
#import "MGTimedMultipleBirdGenerator.h"
#import "MGSceneObjectDestroyer.h"

@interface MGPlayState : MGState {
    MGTimedMultipleBirdGenerator *timedMultipleBirdGenerator;
    MGSceneObjectDestroyer *_birdDestroyer;
    NSMutableArray *sceneObjects;
}

@property (nonatomic, retain) MGSceneObjectDestroyer *birdDestroyer;


- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadPlayState;
- (void)startPlayState;
- (void)updatePlayState;
- (void)renderPlayState;
- (void)stopPlayState;

@end
