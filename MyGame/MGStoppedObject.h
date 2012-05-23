//
//  MGStoppedObject.h
//  MyGame
//
//  Created by Marina Osés Merino on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"
#import "MGSceneObjectDestroyer.h"

@class MGSceneController;


@interface MGStoppedObject : MGSceneObject {

    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    NSInteger lifeTimeInUpdates;
}


@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, assign) NSInteger lifeTimeInUpdates;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;


@end
