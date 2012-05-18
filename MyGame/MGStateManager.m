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
- (id)initWithSceneController:(MGSceneController *)scene_controller TimeController:(MGTimeController *)time_controller {
    self = [super init];
    if (self) {
        _activeState = [[MGPlayState alloc] initWithSceneController:scene_controller TimeController:time_controller];
    }
    return self;
}



#pragma mark - Tratar los diferentes estados


- (void)goToMainState {
    
}

- (void)goToHelpState {
    NSLog(@"In manager: goToHelpState()");

}

- (void)goToPlayState {
    NSLog(@"In manager: goToPlayState()");
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
    [super dealloc];
}

@end
