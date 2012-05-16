//
//  MGDuck.m
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGDuck.h"

#import "MGSceneController.h"

@implementation MGDuck


static CGFloat MGDuckColorValues[16] ={
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0
};


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer RangeForScale:NSMakeRange(MIN_DUCK_SCALE, MAX_DUCK_SCALE) RangeForSpeed:NSMakeRange(MIN_DUCK_SPEED, MAX_DUCK_SPEED) Direction:1];
    if (self) {        
        self.mesh.colors = MGDuckColorValues;
    }
    return self;
}


- (void)update {
    [super update];
}

- (void)dealloc {
    [super dealloc];
}



@end
