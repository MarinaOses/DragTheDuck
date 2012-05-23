//
//  MGBee.h
//  MyGame
//
//  Created by Marina Osés Merino on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGStoppedObject.h"

#define RIGHT (-1)
#define LEFT 1


@class MGSceneController;

@interface MGBee : MGStoppedObject {

}


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;


@end
