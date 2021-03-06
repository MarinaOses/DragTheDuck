//
//  MGNest.m
//  MyGame
//
//  Created by Marina Osés Merino on 09/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGNest.h"

#import "MGSceneController.h"


@implementation MGNest
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize taken;
@synthesize transformationController = _transformationController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize sceneObjects = _sceneObjects;
@synthesize finger = _finger;
@synthesize generatedDuck = _generatedDuck;


- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter TransformationController:(MGTransformationController *)transformation_controller TouchFinger:(MGFinger *)touch_finger SceneObjects:(NSMutableArray *)scene_objects {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_NEST_SCALE, MAX_NEST_SCALE) RangeForSpeed:NSMakeRange(MIN_NEST_SPEED, MAX_NEST_SPEED) Direction:1];
    if (self) {
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.scoreTransmitter = score_transmitter;
        self.transformationController = transformation_controller;
        self.sceneObjects = scene_objects;
        self.finger = touch_finger;
        self.taken = NO;
        throwedDuck = NO;
        timeBeforeTheDuckAppearsInUpdates = SEC_BEFORE_THE_DUCK_APPEARS * MAXIMUM_FRAME_RATE;
        self.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_nest.png"];
        self.translation = [self randomTranslationWithMeshBounds:self.meshBounds OnSide:-self.movingDirection];        
    }
    return self;
}


- (void)update {
    if (timeBeforeTheDuckAppearsInUpdates > 0) {
        NSSet *newTouches = [self.sceneController.inputViewController touchEvents];
        if (!self.taken) {

            BOOL hasArrived = [self.boundaryController hasTheNest:self arrivedToPointX:(self.startingPointX + NEST_ROUTE)];
            if (hasArrived) {
                [self stop];
            }
            if (self.finger.isFree) {
                for (MGTouch *atouch in newTouches) {
                    if (atouch.phase == UITouchPhaseBegan) {
                        CGRect screenRectToAccess = self.screenRect;
                        CGRect touchableArea = CGRectMake(CGRectGetMinX(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DRAGGEABLE, CGRectGetMinY(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DRAGGEABLE, CGRectGetWidth(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DRAGGEABLE*2, CGRectGetHeight(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DRAGGEABLE*2);
                        if (CGRectContainsPoint(touchableArea, atouch.location)) {
                            self.taken = YES;
                            self.finger.isFree = NO;
                            [self stop];
                        }
                    }
                }
            }
        }
        else {
            for (MGTouch *atouch in newTouches) {
                if (atouch.phase == UITouchPhaseMoved) {
                    if (atouch.location.x > GRASS_HEIGHT) {
                        MGPoint touchLocation =  [self.sceneController.inputViewController meshCenterFromMGTouchLocation:atouch.location];
                        if (atouch.location.y > NEST_ROUTE) {
                            self.translation = MGPointMake(self.startingPointX + NEST_ROUTE, touchLocation.y, 0.0);
                        }
                        else {
                            self.translation = touchLocation;
                        }
                    }
                }
                else if (atouch.phase == UITouchPhaseEnded){
                    self.taken = NO;
                    self.finger.isFree = YES;
                    [self start];
                }
            }
        }
        timeBeforeTheDuckAppearsInUpdates--;
    }
    else {
        if (!throwedDuck) {
            MGDuck *duck = [[MGDuck alloc] initWithSceneController:self.sceneController BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTrasnmitter:self.scoreTransmitter TransformationController:self.transformationController TouchFinger:self.finger AppearanceHeight:self.translation.y];
            self.generatedDuck = duck;
            [duck release];
            [self.generatedDuck update];
            [self.generatedDuck render];
            [self.sceneObjects addObject:self.generatedDuck];
            throwedDuck = YES;
            self.taken = NO;
            self.finger.isFree = YES;
            [self start];
        }
    }
    [super update];
}



- (void)dealloc {
    [_scoreTransmitter release];
    [_transformationController release];
    [_sceneObjectDestroyer release];
    [_sceneObjects release];
    [_finger release];
    [_generatedDuck release];
    [super dealloc];
}


@end
