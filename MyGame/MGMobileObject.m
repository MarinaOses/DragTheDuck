//
//  MGMobileObject.m
//  MyGame
//
//  Created by Marina Osés Merino on 07/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"

#import "MGSceneController.h"

@implementation MGMobileObject

@synthesize speed = _speed;

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        self.speed = MGPointMake(0.0, 0.0, 0.0);
    }
    return self;
}




- (void)update {
    MGPoint p = self.translation;
    p.x += self.speed.x;
    p.y += self.speed.y;
    p.z += self.speed.z;
    self.translation = p;
    [super update];
}



- (void)dealloc {
    [super dealloc];
}

@end
