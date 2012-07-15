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


- (void)goToMainState {
    
}

- (void)goToHelpState {
    NSLog(@"In manager: goToHelpState()");

}

- (void)goToPlayState {
    NSLog(@"In manager: goToPlayState()");
    MGPlayState *playStateToAssign = [[MGPlayState alloc] initWithSceneController:self.sceneController];
    self.activeState = playStateToAssign;
    [self.sceneController loadScene];
    [self.sceneController startScene];
    [playStateToAssign release];
}

- (void)goToPauseState {
    
} 

- (void)goToGameOverState {
    
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
