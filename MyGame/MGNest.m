//
//  MGNest.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGNest.h"

#import "MGSceneController.h"

@interface MGNest()
- (void)start;
@end

@implementation MGNest
@synthesize draggeable;
@synthesize taken;
@synthesize finger = _finger;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller TouchFinger:(MGFinger *)touch_finger {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_NEST_SCALE, MAX_NEST_SCALE) RangeForSpeed:NSMakeRange(MIN_NEST_SPEED, MAX_NEST_SPEED) Direction:1];
    if (self) {
        self.draggeable = NO;
        self.taken = NO;
        self.finger = touch_finger;
        savedSpeed = self.speed;
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_nest.png"];
        self.translation = [self randomTranslationWithMeshBounds:self.meshBounds OnSide:-self.movingDirection];
    }
    return self;
}


- (void)update {

    NSSet *newTouches = [self.sceneController.inputViewController touchEvents];
    if (!self.draggeable) {
        BOOL hasArrived = [self.boundaryController hasTheNest:self arrivedToPointX:(-CGRectGetMidY(self.sceneController.openGLView.window.frame) + NEST_ROUTE)];
        if (hasArrived) {
            self.draggeable = YES;
        }
    }
    else {
        if (self.finger.isFree || self.taken) {
            for (MGTouch *atouch in newTouches) {
                if (atouch.phase == UITouchPhaseBegan && atouch.numberOfFingersOnTheScreen == 1) {
                    CGRect screenRectToAccess = self.screenRect;
                    CGRect touchableArea = CGRectMake(CGRectGetMinX(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DRAGGEABLE, CGRectGetMinY(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DRAGGEABLE, CGRectGetWidth(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DRAGGEABLE*2, CGRectGetHeight(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DRAGGEABLE*2);
                    if (CGRectContainsPoint(touchableArea, atouch.location)) {
                        self.taken = YES;
                        self.finger.isFree = NO;
                        [self stop];
                    }
                }
                else if (atouch.phase == UITouchPhaseMoved && taken == YES && atouch.location.x > GRASS_HEIGHT) {
                    self.translation = [self.sceneController.inputViewController meshCenterFromMGTouchLocation:atouch.location];
                }
                else if (atouch.phase == UITouchPhaseEnded){
                    self.taken = NO;
                    self.finger.isFree = YES;
                    self.draggeable = NO;
                    [self start];
                }
            }
        }
    }
    [super update];
}

- (void)start {
    self.speed = savedSpeed;
}

- (void)dealloc {
    [_finger release];
    [super dealloc];
}


@end
