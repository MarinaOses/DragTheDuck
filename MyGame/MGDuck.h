//
//  MGDuck.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"

@class MGSceneController;

@interface MGDuck : MGMobileObject {
    
}

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;

@end
