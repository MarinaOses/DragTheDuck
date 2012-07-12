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
#import "MGMultipleArmorGenerator.h"
#import "MGTakenLeavesButton.h"
#import "MGLifesController.h"
#import "MGCollisionController.h"



@class MGSceneController;

@interface MGPlayState : MGState {
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForDucks;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForBirds;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForLeaves;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForBees;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGCollisionController *_collisionController;
    NSMutableArray *_sceneObjects;
    MGScoreBoard *_scoreBoard;
    MGTakenLeavesButton *_takenLeavesButton;
    MGScoreTransmitter *_scoreTransmitter;
    MGNumbersDelegate *_numbersDelegate;
    MGBoundaryController *_boundaryController;
    MGLifesController *_lifesController;
}

@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGCollisionController *collisionController;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGScoreBoard *scoreBoard;
@property (nonatomic, retain) MGTakenLeavesButton *takenLeavesButton;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGNumbersDelegate *numbersDelegate;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, retain) MGLifesController *lifesController;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadState;
- (void)startState;
- (void)updateState;
- (void)renderState;
- (void)stopState;

@end
