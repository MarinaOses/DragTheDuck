//
//  MGEgg.m
//  MyGame
//
//  Created by Marina Osés Merino on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGEgg.h"



#import "MGSceneController.h"

//static CGFloat MGEggColorValues[16] ={
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0, 
//    0.9, 0.8, 0.7, 1.0
//};


@implementation MGEgg

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller DropsFromKilledDuck:(MGDuck *)duck {
    //CGFloat speedToAssignY = -2*powf(duck.speed.x,2) + duck.translation.y; 
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(duck.scale.x/2.0, duck.scale.x/2.0) RangeForSpeed:NSMakeRange(duck.speed.x*100.0, duck.speed.x*100.0) Direction:1];
    if (self) {
        MGPoint s = MGPointMake(duck.speed.x, EGG_INITIAL_JUMP_SPEED, duck.speed.z);
        self.speed = s;
        self.translation = duck.translation;
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_egg"];
    }
    return self;
}

- (void)update {
    MGPoint s = MGPointMake(self.speed.x, self.speed.y - EGG_ACCELERATION, self.speed.z);
    self.speed = s;
    [super update];
}

- (void)dealloc {
    [super dealloc];
}

@end