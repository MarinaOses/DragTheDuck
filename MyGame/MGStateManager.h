//
//  MGStateManager.h
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGState.h"

@interface MGStateManager : NSObject {
    MGState *_activeState;
}

@property (nonatomic, retain) MGState *activeState;


- (void)goToMainState;
- (void)goToHelpState;
- (void)goToGameState;
- (void)goToPauseState;
- (void)goToGameOverState;
- (void)goToQuitState;
- (void)changeSoundState;

@end
