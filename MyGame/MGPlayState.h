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
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForNests;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForArrows;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForLeaves;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForBees;
    MGCollisionController *_collisionController;
    MGScoreBoard *_scoreBoard;
    MGTakenLeavesButton *_takenLeavesButton;
    MGTexturedButton *_pauseButton;
    MGScoreTransmitter *_scoreTransmitter;
    MGNumbersDelegate *_numbersDelegate;
    MGBoundaryController *_boundaryController;
    MGLifesController *_lifesController;
}

@property (nonatomic, retain) MGCollisionController *collisionController;
@property (nonatomic, retain) MGScoreBoard *scoreBoard;
@property (nonatomic, retain) MGTakenLeavesButton *takenLeavesButton;
@property (nonatomic, retain) MGTexturedButton *pauseButton;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGNumbersDelegate *numbersDelegate;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, retain) MGLifesController *lifesController;

- (id)initWithSceneController:(MGSceneController *)scene_controller;


@end
