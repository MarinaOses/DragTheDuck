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
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize  draggeable;
@synthesize taken;
@synthesize transformationController = _transformationController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize sceneObjects = _sceneObjects;
@synthesize finger = _finger;


- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter TransformationController:(MGTransformationController *)transformation_controller TouchFinger:(MGFinger *)touch_finger SceneObjects:(NSMutableArray *)scene_objects {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_NEST_SCALE, MAX_NEST_SCALE) RangeForSpeed:NSMakeRange(MIN_NEST_SPEED, MAX_NEST_SPEED) Direction:1];
    if (self) {
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.scoreTransmitter = score_transmitter;
        self.transformationController = transformation_controller;
        self.sceneObjects = scene_objects;
        self.finger = touch_finger;
        self.draggeable = NO;
        self.taken = NO;
        throwedDuck = NO;
        timeBeforeTheDuckAppearsInUpdates = SEC_BEFORE_THE_DUCK_APPEARS * MAXIMUM_FRAME_RATE;
        savedSpeed = self.speed;
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_nest.png"];
        self.translation = [self randomTranslationWithMeshBounds:self.meshBounds OnSide:-self.movingDirection];
    }
    return self;
}


- (void)update {
    if (timeBeforeTheDuckAppearsInUpdates <= 0 && !throwedDuck) {
        MGDuck *duck = [[MGDuck alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTrasnmitter:self.scoreTransmitter TransformationController:self.transformationController TouchFinger:self.finger AppearanceHeight:self.translation.y];
        [self.sceneObjects addObject:duck];
        [duck release];
        throwedDuck = YES;
    }
    else {
        timeBeforeTheDuckAppearsInUpdates--;
        CGFloat startingPointX = -CGRectGetMidY(self.sceneController.openGLView.window.frame);
        NSSet *newTouches = [self.sceneController.inputViewController touchEvents];
        if (!self.draggeable) {
            BOOL hasArrived = [self.boundaryController hasTheNest:self arrivedToPointX:(startingPointX + NEST_ROUTE)];
            if (hasArrived) {
                [self stop];
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
                        MGPoint touchLocation =  [self.sceneController.inputViewController meshCenterFromMGTouchLocation:atouch.location];
                        if (atouch.location.y > NEST_ROUTE) {
                            self.translation = MGPointMake(startingPointX + NEST_ROUTE, touchLocation.y, 0.0);
                        }
                        else {
                            self.translation = touchLocation;
                        }
                        
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
    }
    [super update];
}

- (void)start {
    self.speed = savedSpeed;
}

- (void)dealloc {
    [_scoreTransmitter release];
    [_transformationController release];
    [_sceneObjectDestroyer release];
    [_sceneObjects release];
    [_finger release];
    [super dealloc];
}


@end
