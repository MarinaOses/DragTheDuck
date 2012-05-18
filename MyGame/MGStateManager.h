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

@interface MGStateManager : NSObject {
    MGState *_activeState;
}

@property (nonatomic, retain) MGState *activeState;

- (id)initWithSceneController:(MGSceneController *)scene_controller TimeController:(MGTimeController *)time_controller;
- (void)goToMainState;
- (void)goToHelpState;
- (void)goToPlayState;
- (void)goToPauseState;
- (void)goToGameOverState;
- (void)changeSoundState;

@end
