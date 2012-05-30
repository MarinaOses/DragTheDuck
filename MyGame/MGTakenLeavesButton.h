//
//  MGTakenLeavesButton.h
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGButton.h"
#import "MGTakenLeavesButtonShowerLayer.h"
#import "MGScoreBoard.h"

@interface MGTakenLeavesButton : MGButton {
    MGScoreBoard *_scoreBoard;
    MGTakenLeavesButtonShowerLayer *_takenLeavesButtonShowerLayer;
    BOOL isActive;
    NSInteger previousTakenLeaves;
}

@property (nonatomic, retain) MGScoreBoard *scoreBoard;
@property (nonatomic, retain) MGTakenLeavesButtonShowerLayer *takenLeavesButtonShowerLayer;
@property (nonatomic, assign) BOOL isActive;



- (id)initWithSceneController:(MGSceneController *)scene_controller Translation:(MGPoint)button_translation Rotation:(MGPoint)button_rotation Scale:(MGPoint)button_scale scoreBoard:(MGScoreBoard *)score_board;

@end
