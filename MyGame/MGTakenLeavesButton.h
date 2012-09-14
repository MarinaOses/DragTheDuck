//
//  MGTakenLeavesButton.h
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTexturedButton.h"
#import "MGTakenLeavesButtonShowerLayer.h"
#import "MGScoreBoard.h"

@interface MGTakenLeavesButton : MGTexturedButton {
    MGScoreBoard *_scoreBoard;
    MGTakenLeavesButtonShowerLayer *_takenLeavesButtonShowerLayer;
    BOOL isActive;
    NSInteger previousTakenLeaves;
    MGSoundSourceObject *_soundSourceObjectForLeavesButtonActive;
}

@property (nonatomic, retain) MGScoreBoard *scoreBoard;
@property (nonatomic, retain) MGTakenLeavesButtonShowerLayer *takenLeavesButtonShowerLayer;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, retain) MGSoundSourceObject *soundSourceObjectForLeavesButtonActive;


- (id)initWithSceneController:(MGSceneController *)scene_controller Translation:(MGPoint)button_translation Rotation:(MGPoint)button_rotation Scale:(MGPoint)button_scale scoreBoard:(MGScoreBoard *)score_board;
- (void)playSoundLeavesButtonActive;

@end
