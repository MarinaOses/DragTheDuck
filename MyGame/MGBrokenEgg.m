//
//  MGBrokenEgg.m
//  MyGame
//
//  Created by Marina Osés Merino on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBrokenEgg.h"

#import "MGSceneController.h"
#import "MGLifesController.h"

//static CGFloat MGBrokenEggColorValues[16] ={
//    0.9, 0.7, 0.5, 1.0, 
//    0.9, 0.7, 0.5, 1.0, 
//    0.9, 0.7, 0.5, 1.0, 
//    0.9, 0.7, 0.5, 1.0
//};

@interface MGBrokenEgg()
- (MGPoint)speedToGoFrom:(MGPoint)start To:(MGPoint)finish In:(NSInteger)updates;
@end

@implementation MGBrokenEgg
@synthesize lifesController = _lifesController;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller  LifesController:(MGLifesController *)lifes_controller ComesFromEgg:(MGEgg *)egg {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(egg.scale.x, egg.scale.x) RangeForSpeed:NSMakeRange(0.0, 0.0) Direction:1];
    if (self) {
        self.lifesController = lifes_controller;
        MGSceneObject *life = (MGSceneObject *)[self.lifesController.lifesMarker objectAtIndex:self.lifesController.nextLifeWithoutUsing];
        finishingPoint = life.translation;
        self.translation = MGPointMake(egg.translation.x, egg.translation.y + CGRectGetHeight(egg.meshBounds), 0.0) ;
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_broken_egg"];
        self.speed = [self speedToGoFrom:self.translation To:finishingPoint In:UPDATES_FOR_A_TRAVEL];
        if (self.speed.x < 0) {
            fallingDirection = -1;
        }
        else {
            fallingDirection = 1;
        }
    }
    return self;
}

- (MGPoint)speedToGoFrom:(MGPoint)start To:(MGPoint)finish In:(NSInteger)updates {
    return MGPointMake((finish.x - start.x)/updates, (finish.y - start.y)/updates, (finish.z - start.z)/updates);
}

- (void)update {
    [self.boundaryController checkIf:self HasArrivedTo:finishingPoint FallingInDirection:fallingDirection];  
    [super update];
}

- (void)dealloc {
    [_lifesController release];
    [super dealloc];
}

@end
