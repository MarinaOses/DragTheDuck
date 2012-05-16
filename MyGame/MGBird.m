//
//  MGBird.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBird.h"

#import "MGSceneController.h"

@implementation MGBird


static CGFloat MGBirdColorValues[16] ={
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0
};


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer RangeForScale:NSMakeRange(MIN_BIRD_SCALE, MAX_BIRD_SCALE) RangeForSpeed:NSMakeRange(MIN_BIRD_SPEED, MAX_BIRD_SPEED) Direction:-1];
    if (self) {
        self.mesh.colors = MGBirdColorValues;
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
