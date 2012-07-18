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

- (void)startState {
    [self.sceneController loadScene];
    [self.sceneController startScene];
}


- (void)goToMainState {
    NSLog(@"In manager: goToMainState()");
    MGMainState *mainStateToAssign = [[MGMainState alloc] initWithSceneController:self.sceneController];
    self.activeState = mainStateToAssign;
    [self startState];
    [mainStateToAssign release];
}

- (void)goToHelpState {
    NSLog(@"In manager: goToHelpState()");
    MGHelpState *helpStateToAssign = [[MGHelpState alloc] initWithSceneController:self.sceneController];
    self.activeState = helpStateToAssign;
    [self startState];
    [helpStateToAssign release];
}

- (void)goToPlayState {
    NSLog(@"In manager: goToPlayState()");
    MGPlayState *playStateToAssign = [[MGPlayState alloc] initWithSceneController:self.sceneController];
    self.activeState = playStateToAssign;
    [self startState];
    [playStateToAssign release];
}

- (void)goToPauseState {

} 

- (void)goToGameOverStateWith:(MGScoreBoard *)score_board {
    NSLog(@"In manager: goToGameOverState()");
    MGGameOverState *gameOverStateToAssign = [[MGGameOverState alloc] initWithSceneController:self.sceneController ScoreBoard:score_board];
    self.activeState = gameOverStateToAssign;
    [self startState];
    [gameOverStateToAssign release];
}

- (void)changeSoundState {
    //Se realizará al final de todo
    NSLog(@"In manager: ChangeSoundState()");
}


- (void)dealloc {
    [_activeState release];
    [_sceneController release];
    [super dealloc];
}

@end
