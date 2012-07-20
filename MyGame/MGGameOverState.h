//
//  MGGameOverState.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"
#import "MGScoreBoard.h"
#import "MGNumbersDelegate.h"

@class MGSceneController;

@interface MGGameOverState : MGState {
    MGNumbersDelegate *_numbersDelegate;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGScoreBoard *_scoreBoard;
}

@property (nonatomic, retain) MGNumbersDelegate *numbersDelegate;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGScoreBoard *scoreBoard;

- (id)initWithSceneController:(MGSceneController *)scene_controller ScoreBoard:(MGScoreBoard *)score_board;
@end
