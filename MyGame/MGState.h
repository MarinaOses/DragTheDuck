//
//  MGState.h
//  MyGame
//
//  Created by Marina Osés Merino on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGSceneController;
@class MGStateManager;

@interface MGState : NSObject {
    MGSceneController *_sceneControllerForState;
    MGStateManager *_stateManager;
}

@property (nonatomic, retain) MGSceneController *sceneControllerForState;
@property (nonatomic, retain) MGStateManager *stateManager;

- (id)initWithSceneController:(MGSceneController *)scene_controller andWithStateManager:(MGStateManager *)state_manager;

@end
