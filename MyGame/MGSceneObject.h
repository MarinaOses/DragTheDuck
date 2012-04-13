//
//  SceneObject.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGPoint.h"
#import "MGMesh.h"


@class MGSceneController;

@interface MGSceneObject : NSObject {
    MGPoint translation;
    MGPoint rotation;
    MGPoint scale;
    
    MGMesh *mesh;
    
    BOOL active;
    
    MGSceneController *sceneController;
}

- (void)awake;
- (id)initWithSceneController:(MGSceneController *)scene_controller;

@end
