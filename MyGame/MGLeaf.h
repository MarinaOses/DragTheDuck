//
//  Leaf.h
//  MyGame
//
//  Created by Marina Osés Merino on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"
#import "MGTimeController.h"
#import "MGSceneObjectDestroyer.h"

@class MGSceneController;

@interface MGLeaf : MGSceneObject {
    MGTimeController *_timeController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    NSInteger lifeTimeInUpdates;
}

@property (nonatomic, retain) MGTimeController *timeController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, assign) NSInteger lifeTimeInUpdates;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer TimeController:(MGTimeController *)time_controller;

@end
