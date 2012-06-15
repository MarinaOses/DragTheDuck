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


@class MGSceneController;

@interface MGPlayState : MGState {
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForDucks;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForBirds;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForLeaves;
    MGTimedMultipleObjectGenerator *timedMultipleObjectGeneratorForBees;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGTimeController *_timeController;
    NSMutableArray *_sceneObjects;
    MGScoreBoard *_scoreBoard;
    MGTakenLeavesButton *_takenLeavesButton;
    MGScoreTransmitter *_scoreTransmitter;
    MGNumbersDelegate *_numbersDelegate;
}

@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGTimeController *timeController;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGScoreBoard *scoreBoard;
@property (nonatomic, retain) MGTakenLeavesButton *takenLeavesButton;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGNumbersDelegate *numbersDelegate;

- (id)initWithSceneController:(MGSceneController *)scene_controller TimeController:(MGTimeController *)time_controller;
- (void)loadPlayState;
- (void)startPlayState;
- (void)updatePlayState;
- (void)renderPlayState;
- (void)stopPlayState;

@end
