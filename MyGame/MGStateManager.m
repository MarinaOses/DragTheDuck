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







- (void)goToMainState {
    
}

- (void)goToHelpState {
    
}

- (void)goToGameState {
    
}

- (void)goToPauseState {
    
} 

- (void)goToGameOverState {
    
}

- (void)goToQuitState {
    
}

- (void)changeSoundState {
    //Se realizará al final de todo
}


- (void)dealloc {
    [_activeState release];
    [super dealloc];
}

@end
