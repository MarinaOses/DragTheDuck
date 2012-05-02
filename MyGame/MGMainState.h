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

@class MGStateManager;

@interface MGMainState : MGState {
    NSMutableArray *interfaceObjects;    
}

- (id)initWithSceneController:(MGSceneController *)scene_controller andWithStateManager:(MGStateManager *)state_manager;

@end
