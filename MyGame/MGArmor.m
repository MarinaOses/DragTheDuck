//
//  MGArmour.m
//  MyGame
//
//  Created by Marina Osés Merino on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGArmor.h"


#import "MGSceneController.h"

//static CGFloat MGArmorColorValues[16] ={
//    0.2, 0.0, 0.0, 1.0, 
//    0.2, 0.0, 0.0, 1.0, 
//    0.0, 0.7, 0.0, 1.0, 
//    0.0, 0.7, 0.0, 1.0
//};


@implementation MGArmor

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller ToPutItOnDuck:(MGDuck *)duck {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(duck.scale.x, duck.scale.x) RangeForSpeed:NSMakeRange((NSUInteger)(roundf(duck.speed.x*100.0)), (NSUInteger)(roundf(duck.speed.x*100.0))) Direction:1];
    if (self) {
        self.translation = duck.translation;
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_hojas.png"];
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
