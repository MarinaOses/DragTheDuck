//
//  MGBird.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBird.h"

#import "MGSceneController.h"




static CGFloat MGBirdWingsDownColorValues[16] ={
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0, 
    1.0, 0.0, 0.0, 1.0
};

static CGFloat MGBirdWingsUpColorValues[16] ={
    0.5, 0.0, 0.0, 1.0, 
    0.5, 0.0, 0.0, 1.0, 
    0.5, 0.0, 0.0, 1.0, 
    0.5, 0.0, 0.0, 1.0
};

@implementation MGBird




- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_BIRD_SCALE, MAX_BIRD_SCALE) RangeForSpeed:NSMakeRange(MIN_BIRD_SPEED, MAX_BIRD_SPEED) Direction:-1];
    if (self) {
        wingsDown = YES;
        [self flapItsWings];    
        [self loadTimeToFlapItsWingsInUpdates];
    }
    return self;
}

- (void)loadTimeToFlapItsWingsInUpdates {
    timeToFlapItsWingsInUpdates = (TIME_TO_FLAP_ITS_WINGS * MAXIMUM_FRAME_RATE) / (self.speed.x * self.movingDirection);
}

- (void)flapItsWings {
    if (wingsDown) {
        self.mesh.colors = MGBirdWingsDownColorValues;
    }
    else {
        self.mesh.colors = MGBirdWingsUpColorValues;
    }
    
}

- (void)update {
    timeToFlapItsWingsInUpdates--;
    if (timeToFlapItsWingsInUpdates <= 0) {
        [self flapItsWings];
        wingsDown = !wingsDown;
        [self loadTimeToFlapItsWingsInUpdates];
        
    }
    [super update];
}




- (void)dealloc {
    [super dealloc];
}






@end
