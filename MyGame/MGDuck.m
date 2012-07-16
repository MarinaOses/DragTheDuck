//
//  MGDuck.m
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGDuck.h"

#import "MGSceneController.h"
#import "MGTransformationController.h"


@interface MGDuck()
- (void)start;
- (void)loadTakenTimeWithoutMovingInUpdates;
@end

static CGFloat MGDuckWingsDownColorValues[16] ={
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0, 
    1.0, 1.0, 0.0, 1.0
};


static CGFloat MGDuckWingsUpColorValues[16] ={
    0.9, 0.9, 0.5, 1.0, 
    0.9, 0.9, 0.5, 1.0, 
    0.9, 0.9, 0.5, 1.0, 
    0.9, 0.9, 0.5, 1.0
};

@implementation MGDuck
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize  draggeable;
@synthesize taken;
@synthesize transformationController = _transformationController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize finger = _finger;
@synthesize wingsDown;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter TransformationController:(MGTransformationController *)transformation_controller TouchFinger:(MGFinger *)touch_finger {
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_DUCK_SCALE, MAX_DUCK_SCALE) RangeForSpeed:NSMakeRange(MIN_DUCK_SPEED, MAX_DUCK_SPEED) Direction:1];
    if (self) { 
        self.collider.checkForCollision = YES;
        self.draggeable = YES;
        self.taken = NO;
        self.scoreTransmitter = score_transmitter;
        self.transformationController = transformation_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.finger = touch_finger;
        savedSpeed = self.speed;
        [self loadTakenTimeWithoutMovingInUpdates];
        wingsDown = YES;
        [self flapItsWings];
        [self loadTimeToFlapItsWingsInUpdates];

    }
    return self;
}


- (void)collideWith:(MGSceneObject *)scene_object {
    if (![scene_object isKindOfClass:[MGBird class]] && ![scene_object isKindOfClass:[MGBee class]] && ![scene_object isKindOfClass:[MGLeaf class]]) {
        return;
    }
    if ([scene_object isKindOfClass:[MGBird class]]) {
        self.collider.checkForCollision = NO;
        if (self.taken) {
            self.finger.isFree = YES;
        }
        //Animacion: igual no hace falta el remove
        [self.sceneObjectDestroyer markToRemoveSceneObject:self];
        [self.scoreTransmitter aNewDuckIsKilled];
        [self.transformationController spawnFeathersFrom:self];
        [self.transformationController spawnEggFrom:self];
        //sumar a marcador "número de patos muertos"
        
    }
    else if ([scene_object isKindOfClass:[MGBee class]]) {
        if ([self.scoreTransmitter isPossibleToCollideWithLeaves]) {
            //Animacion para borrar la abeja
            [self.sceneObjectDestroyer markToRemoveSceneObject:scene_object];
            [self.scoreTransmitter aNewBeeIsTaken];
            [self.transformationController spawnBeeFrom:self];
            [self.sceneObjectDestroyer markToRemoveSceneObject:self];
        }
    }
    else { //hoja
        if ([self.scoreTransmitter isPossibleToCollideWithLeaves]) {
            [self.sceneObjectDestroyer markToRemoveSceneObject:scene_object];
            [self.scoreTransmitter aNewLeafIsTaken];
        }
    }
}

- (void)loadTimeToFlapItsWingsInUpdates {
    timeToFlapItsWingsInUpdates = (TIME_TO_FLAP_ITS_WINGS * MAXIMUM_FRAME_RATE) / (self.speed.x * self.movingDirection);
}


- (void)flapItsWings {
    if (wingsDown) {
        self.mesh.colors = MGDuckWingsDownColorValues;
    }
    else {
        self.mesh.colors = MGDuckWingsUpColorValues;
    }
}

- (void)update {
    if (!self.taken) {
        timeToFlapItsWingsInUpdates--;
        if (timeToFlapItsWingsInUpdates <= 0) {
            [self flapItsWings];
            wingsDown = !wingsDown;
            [self loadTimeToFlapItsWingsInUpdates];
            
        }

    }
    NSSet *newTouches = [self.sceneController.inputViewController touchEvents];
    if (self.taken && [newTouches count] == 0) {
        takenTimeWithoutMovingInUpdates--;
        if (takenTimeWithoutMovingInUpdates <= 0) {
            self.taken = NO;
            self.finger.isFree = YES;
            [self start];
        }
    }
    else {
        if (self.draggeable && (self.finger.isFree || self.taken)) {
            for (MGTouch *atouch in newTouches) {
                
                if (atouch.phase == UITouchPhaseBegan && atouch.numberOfFingersOnTheScreen == 1) {
                    CGRect screenRectToAccess = self.screenRect;
                    CGRect touchableArea = CGRectMake(CGRectGetMinX(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DUCKS, CGRectGetMinY(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DUCKS, CGRectGetWidth(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DUCKS*2, CGRectGetHeight(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DUCKS*2);
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
                    [self start];
                }
            }
        }
        [self loadTakenTimeWithoutMovingInUpdates];
    }
    [super update];
}

- (void)loadTakenTimeWithoutMovingInUpdates {
    takenTimeWithoutMovingInUpdates = TAKEN_TIME_WITHOUT_MOVING * MAXIMUM_FRAME_RATE;
}


- (void)start {
    self.speed = savedSpeed;
}



- (void)dealloc {
    [_scoreTransmitter release];
    [_transformationController release];
    [_sceneObjectDestroyer release];
    [_finger release];
    [super dealloc];
}



@end
