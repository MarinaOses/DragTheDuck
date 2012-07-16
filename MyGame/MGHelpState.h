//
//  MGHelpState.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGState.h"

@class MGSceneController;

@interface MGHelpState : MGState {
    NSMutableArray *_sceneObjects;
}


@property (nonatomic, retain) NSMutableArray *sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadState;
- (void)updateState;
- (void)renderState;
@end

