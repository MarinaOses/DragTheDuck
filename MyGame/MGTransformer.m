//
//  MGTransformer.m
//  MyGame
//
//  Created by Marina Osés Merino on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTransformer.h"

#import "MGSceneController.h"
#import "MGTransformationController.h"

@interface MGTransformer()
- (CGFloat)randomLifeTime;
- (void)stop;
- (void)start;
- (void)loadTakenTimeWithoutMovingInUpdates;
@end


static CGFloat MGTransformerColorValues[16] = {
    1.0, 0.5, 0.3, 1.0,
    1.0, 0.5, 0.3, 1.0,
    1.0, 0.5, 0.3, 1.0,
    1.0, 0.5, 0.3, 1.0
};


@implementation MGTransformer
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize transformationController = _transformationController;
@synthesize sceneObjectDestroyer =_sceneObjectDestroyer;
@synthesize finger = _finger;
@synthesize taken;


- (id)initWithDuck:(MGDuck *)duck {
    
    self = [super initWithSceneController:duck.sceneController BoundaryController:duck.boundaryController RangeForScale:NSMakeRange(MIN_TRANSFORMER_SCALE, MAX_TRANSFORMER_SCALE) RangeForSpeed:NSMakeRange(MIN_TRANSFORMER_SPEED, MAX_TRANSFORMER_SPEED) Direction:1];
    if (self) {
        savedSpeed = self.speed;
        self.taken = duck.taken;
        if (self.taken) {
            self.speed = duck.speed;
        }
        self.mesh.colors = MGTransformerColorValues;
        self.translation = duck.translation;
        self.collider.checkForCollision = YES;
        self.scoreTransmitter = duck.scoreTransmitter;
        self.transformationController = duck.transformationController;
        lifeTimeInUpdates = (int) ([self randomLifeTime] * MAXIMUM_FRAME_RATE);
        self.sceneObjectDestroyer = duck.sceneObjectDestroyer;
        self.finger = duck.finger;
        [self loadTakenTimeWithoutMovingInUpdates];
    }
    return self;
}

- (CGFloat)randomLifeTime {
    return RANDOM_FLOAT(MINSEC_TO_TRANSFORMER_DISAPPEARANCE, MAXSEC_TO_TRANSFORMER_DISAPPEARANCE);
}

- (void)collideWith:(MGSceneObject *)scene_object {
    if (![scene_object isKindOfClass:[MGBird class]]) {
        return;
    }
    else {
        //Animacion: igual no hace falta el remove
        [self.sceneObjectDestroyer markToRemoveSceneObject:scene_object];
        //sumar a marcador "número de pájaros muertos"
        [self.scoreTransmitter aNewBirdIsKilled];
    }
}

- (void)update {
    //Ha habido algún toque?
    //touchEvents contiene todos los toques o deslizamientos que se an hecho en pantalla
    lifeTimeInUpdates--;
    if (lifeTimeInUpdates <= 0) {
        [self.transformationController spawnDuckFrom:self];
        [self.sceneObjectDestroyer markToRemoveSceneObject:self];
        [self.scoreTransmitter theTransformerHasCrossedTheLine];
    }
    else {
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
            if (self.finger.isFree || self.taken) {
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
    }
    [super update];
}


- (void)loadTakenTimeWithoutMovingInUpdates {
    takenTimeWithoutMovingInUpdates = TAKEN_TIME_WITHOUT_MOVING * MAXIMUM_FRAME_RATE;
}

- (void)stop {
    self.speed = MGPointMake(0.0, 0.0, 0.0);
}

- (void)start {
    self.speed = savedSpeed;
}


- (void)dealloc {
    [_scoreTransmitter release];
    [_tranformationController release];
    [_sceneObjectDestroyer release];
    [_finger release];
    [super dealloc];
}

@end
