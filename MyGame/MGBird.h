//
//  MGBird.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"

@class MGSceneController;

@interface MGBird : MGSceneObject {
    MGPoint _speed;
}

@property (nonatomic, assign) MGPoint speed;

- (id)initWithSceneController:(MGSceneController *)scene_controller;



@end
