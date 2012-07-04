//
//  MGFeathers.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGStoppedObject.h"

@class MGSceneController;


@interface MGFeathers : MGStoppedObject


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer Translation:(MGPoint)feathers_translation Scale:(MGPoint)feathers_scale Color:(CGFloat *)feathers_color;

@end
