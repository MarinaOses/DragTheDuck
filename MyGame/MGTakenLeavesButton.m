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
        self.translation = MGPointMake(button_translation.x, button_translation.y, button_translation.z);
        self.rotation = MGPointMake(button_rotation.x, button_rotation.y, button_rotation.z);
        self.scale = MGPointMake(button_scale.x, button_scale.y, button_scale.z);
            
        MGTakenLeavesButtonShowerLayer *takenLeavesButtonShowerLayerToAssign = [[MGTakenLeavesButtonShowerLayer alloc] initWithSceneController:scene_controller];
        self.takenLeavesButtonShowerLayer = takenLeavesButtonShowerLayerToAssign;
        [takenLeavesButtonShowerLayerToAssign release];
        
        self.takenLeavesButtonShowerLayer.translation = MGPointMake(button_translation.x, button_translation.y, button_translation.z);
        self.takenLeavesButtonShowerLayer.rotation = MGPointMake(button_rotation.x, button_rotation.y, button_rotation.z);
        self.takenLeavesButtonShowerLayer.scale = MGPointMake(button_scale.x, button_scale.y, button_scale.z);
        
        isActive = NO;
    }
    return self;
}

- (void)goodTouch {
    if (isActive) {
        [super goodTouch];
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
            [self.takenLeavesButtonShowerLayer decreaseHeight];
            previousTakenLeaves = taken_leaves_now;
        }
    }
    else if (taken_leaves_now == MAX_TAKEN_LEAVES){
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
