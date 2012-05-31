//
//  MGTakenLeavesButton.m
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTakenLeavesButton.h"

@implementation MGTakenLeavesButton

@synthesize scoreBoard = _scoreBoard;
@synthesize takenLeavesButtonShowerLayer = _takenLeavesButtonShowerLayer;
@synthesize isActive;


- (id)initWithSceneController:(MGSceneController *)scene_controller Translation:(MGPoint)button_translation Rotation:(MGPoint)button_rotation Scale:(MGPoint)button_scale scoreBoard:(MGScoreBoard *)score_board {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        
        self.scoreBoard = score_board;
        previousTakenLeaves = 0;
        self.translation = button_translation;
        self.rotation = button_rotation;
        self.scale = button_scale;
            
        MGTakenLeavesButtonShowerLayer *takenLeavesButtonShowerLayerToAssign = [[MGTakenLeavesButtonShowerLayer alloc] initWithSceneController:scene_controller Translation:button_translation Rotation:button_rotation Scale:button_scale];
        self.takenLeavesButtonShowerLayer = takenLeavesButtonShowerLayerToAssign;
        [takenLeavesButtonShowerLayerToAssign release];
        
        isActive = NO;
        
    }
    return self;
}

- (void)goodTouch {
    if (isActive) {
        [super goodTouch];
        self.takenLeavesButtonShowerLayer.scale = self.scale;
        self.takenLeavesButtonShowerLayer.translation = self.translation;
    }
}

-(void)badTouch {
    if (isActive) {
        [super badTouch];
    }
}

- (void)checkIfShowerLayerHasToGoUp:(NSInteger)taken_leaves_now {
    if (taken_leaves_now < MAX_TAKEN_LEAVES) {
        if (previousTakenLeaves < taken_leaves_now) {
            [self.takenLeavesButtonShowerLayer decreaseHeight:(MAX_TAKEN_LEAVES - taken_leaves_now)];
            previousTakenLeaves = taken_leaves_now;
        }
    }
    else if (taken_leaves_now == MAX_TAKEN_LEAVES){
        [self.takenLeavesButtonShowerLayer decreaseHeight:(MAX_TAKEN_LEAVES - taken_leaves_now)];
        isActive = YES;
        self.scoreBoard.takenLeaves = 0;
        
    }
}

- (void)update {
    [self checkIfShowerLayerHasToGoUp:self.scoreBoard.takenLeaves];    
    [super update];
}

- (void)dealloc {
    [_scoreBoard release];
    [_takenLeavesButtonShowerLayer release];
    [super dealloc];
}


@end
