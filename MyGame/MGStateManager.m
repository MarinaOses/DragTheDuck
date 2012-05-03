//
//  MGStateManager.m
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGStateManager.h"

@implementation MGStateManager

@synthesize activeState = _activeState;


//Creo el manager inicializando su estado activo al estado principal o MainState
- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.activeState = [[MGMainState alloc] initWithSceneController:scene_controller];
    }
    return self;
}



#pragma mark - Tratar los diferentes estados


- (void)goToMainState {
    
}

- (void)goToHelpState {
    NSLog(@"In manager: goToHelpState()");

}

- (void)goToGameState {
    NSLog(@"In manager: goToGameState()");
}

- (void)goToPauseState {
    
} 

- (void)goToGameOverState {
    
}

- (void)goToQuitState {
    NSLog(@"In manager: goToQuitState()");

}

- (void)changeSoundState {
    //Se realizará al final de todo
    NSLog(@"In manager: ChangeSoundState()");
}


- (void)dealloc {
    [_activeState release];
    [super dealloc];
}

@end
