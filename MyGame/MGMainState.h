//
//  MGMainState.h
//  MyGame
//
//  Created by Marina Osés Merino on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MGButton.h"
#import "MGState.h"

@class MGSceneController;

@interface MGMainState : MGState {
    NSMutableArray *sceneObjects;    
}

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (void)loadMainState;
- (void)updateMainState;
- (void)renderMainState;
@end
