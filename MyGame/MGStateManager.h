//
//  MGStateManager.h
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MGMainState.h"
#import "MGPlayState.h"
#import "MGHelpState.h"
#import "MGGameOverState.h"

@class MGSceneController;

@interface MGStateManager : NSObject {
    MGState *_activeState;
    MGSceneController *_sceneController;
}

@property (nonatomic, retain) MGState *activeState;
@property (nonatomic, retain) MGSceneController *sceneController;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)goToMainState;
- (void)goToHelpState;
- (void)goToPlayState;
- (void)goToPauseState;
- (void)goToGameOverStateWith:(MGScoreBoard *)score_board;
- (void)changeSoundState;
- (void)stopActiveState;

@end
