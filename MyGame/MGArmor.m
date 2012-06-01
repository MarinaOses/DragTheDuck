//
//  MGArmour.m
//  MyGame
//
//  Created by Marina Osés Merino on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGArmor.h"


#import "MGSceneController.h"

static CGFloat MGArmorColorValues[16] ={
    0.2, 0.0, 0.0, 1.0, 
    0.2, 0.0, 0.0, 1.0, 
    0.0, 0.7, 0.0, 1.0, 
    0.0, 0.7, 0.0, 1.0
};


@implementation MGArmor

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ToPutItOnDuck:(MGDuck *)duck {
    self = [super initWithSceneController:scene_controller SceneObjectDestroyer:scene_object_destroyer RangeForScale:NSMakeRange(duck.scale.x, duck.scale.x) RangeForSpeed:NSMakeRange(duck.speed.x*100.0, duck.speed.x*100.0) Direction:1];
    if (self) {
        self.translation = duck.translation;
        self.mesh.colors = MGArmorColorValues;
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
