//
//  MGStateManager.m
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGStateManager.h"

#import "MGSceneController.h"

@interface MGStateManager()
- (void)loadFirstState;
@end

@implementation MGStateManager

@synthesize activeState = _activeState;
@synthesize sceneController = _sceneController;
@synthesize playStateToRemember = _playStateToRemember;


//Creo el manager inicializando su estado activo al estado principal o MainState
- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        [self loadFirstState];
    }
    return self;
}



#pragma mark - Tratar los diferentes estados

- (void)loadFirstState {
    _activeState = [[MGMainState alloc] initWithSceneController:self.sceneController];
}

- (void)stopActiveState {
    [self.activeState stopState];
}

- (void)activateState {
    [self.sceneController loadScene];
    [self.sceneController startScene];
}

- (void)reactivateState {
    [self.sceneController startScene];
}


- (void)goToMainState {
    MGMainState *mainStateToAssign = [[MGMainState alloc] initWithSceneController:self.sceneController];
    self.activeState = mainStateToAssign;
    [self activateState];
    [mainStateToAssign release];
}

- (void)goToHelpState {
    MGHelpState *helpStateToAssign = [[MGHelpState alloc] initWithSceneController:self.sceneController];
    self.activeState = helpStateToAssign;
    [self activateState];
    [helpStateToAssign release];
}

- (void)goToPlayState {
    [[MGOpenALSoundController sharedSoundController] stopALLPlayingSounds];
    MGPlayState *playStateToAssign = [[MGPlayState alloc] initWithSceneController:self.sceneController];
    [playStateToAssign.background playSound];
    self.activeState = playStateToAssign;
    [self.sceneController.timeController start];
    [self activateState];
    [playStateToAssign release];
}

- (void)goToPauseState {
    [[MGOpenALSoundController sharedSoundController] pauseALLPlayingSounds];
    if ([self.activeState isKindOfClass:[MGPlayState class]]) {
        self.playStateToRemember = (MGPlayState *)self.activeState;
        [self.sceneController.timeController deactivate];
        MGPauseState *pauseStateToAssign = [[MGPauseState alloc] initWithSceneController:self.sceneController SceneObjects:self.playStateToRemember.sceneObjects PauseButton:self.playStateToRemember.pauseButton];
        self.activeState = pauseStateToAssign;
        [self activateState];
        [pauseStateToAssign release];
    }
} 

- (void)goToGameOverStateWith:(MGScoreBoard *)score_board {
    [[MGOpenALSoundController sharedSoundController] stopALLPlayingSounds];
    [self.sceneController.timeController deactivate];
    MGGameOverState *gameOverStateToAssign = [[MGGameOverState alloc] initWithSceneController:self.sceneController ScoreBoard:score_board];
    self.activeState = gameOverStateToAssign;
    [self activateState];
    [gameOverStateToAssign release];
}

- (void)restartPlayState {
    [[MGOpenALSoundController sharedSoundController] restartALLPlayingSounds];
    self.activeState = self.playStateToRemember;
    [self reactivateState];    
    [self.sceneController.timeController activate];
}




- (void)dealloc {
    [_activeState release];
    [_sceneController release];
    [_playStateToRemember release];
    [super dealloc];
}

@end
