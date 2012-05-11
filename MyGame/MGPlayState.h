//
//  MGPlayState.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"
#import "MGTimedMultipleBirdGenerator.h"
#import "MGBirdDestroyer.h"

@interface MGPlayState : MGState {
    MGTimedMultipleBirdGenerator *timedMultipleBirdGenerator;
    MGBirdDestroyer *_birdDestroyer;
    NSMutableArray *sceneObjects;
}

@property (nonatomic, retain) MGBirdDestroyer *birdDestroyer;


- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadPlayState;
- (void)updatePlayState;
- (void)renderPlayState;

@end
