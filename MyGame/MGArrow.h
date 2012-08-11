//
//  MGArrow.h
//  MyGame
//
//  Created by Marina Osés Merino on 11/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBird.h"

@class MGSceneController;

@interface MGArrow : MGMobileObject {
    BOOL timeBeforeTheBirdAppearsInUpdates;
    BOOL throwedBird;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    NSMutableArray *_sceneObjects;
}


@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) NSMutableArray *sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer SceneObjects:(NSMutableArray *)scene_objects;

@end
