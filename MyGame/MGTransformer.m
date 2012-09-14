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
- (void)loadTakenTimeWithoutMovingInUpdates;
@end


//static CGFloat MGTransformerWingsDownColorValues[16] = {
//    1.0, 0.5, 0.3, 1.0,
//    1.0, 0.5, 0.3, 1.0,
//    1.0, 0.5, 0.3, 1.0,
//    1.0, 0.5, 0.3, 1.0
//};
//
//static CGFloat MGTransformerWingsUpColorValues[16] = {
//    1.0, 0.6, 0.5, 1.0,
//    1.0, 0.6, 0.5, 1.0,
//    1.0, 0.6, 0.5, 1.0,
//    1.0, 0.6, 0.5, 1.0
//};


@implementation MGTransformer
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize transformationController = _transformationController;
@synthesize sceneObjectDestroyer =_sceneObjectDestroyer;
@synthesize finger = _finger;
@synthesize taken;
@synthesize downWingsQuad = _downWingsQuad;
@synthesize upWingsQuad = _upWingsQuad;


- (id)initWithDuck:(MGDuck *)duck {
    
    self = [super initWithSceneController:duck.sceneController BoundaryController:duck.boundaryController RangeForScale:NSMakeRange(MIN_TRANSFORMER_SCALE, MAX_TRANSFORMER_SCALE) RangeForSpeed:NSMakeRange(MIN_TRANSFORMER_SPEED, MAX_TRANSFORMER_SPEED) Direction:1];
    if (self) {
        self.taken = duck.taken;
        if (self.taken) {
            self.speed = duck.speed;
        }
        self.translation = duck.translation;
        self.collider.checkForCollision = YES;
        self.scoreTransmitter = duck.scoreTransmitter;
        self.transformationController = duck.transformationController;
        lifeTimeInUpdates = (int) ([self randomLifeTime] * MAXIMUM_FRAME_RATE);
        self.sceneObjectDestroyer = duck.sceneObjectDestroyer;
        self.finger = duck.finger;
        [self loadTakenTimeWithoutMovingInUpdates];
        wingsDown = duck.wingsDown;
        self.downWingsQuad = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_transformer_ala_abajo.png"];
        self.upWingsQuad = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_transformer_ala_arriba.png"];
        [self flapItsWings];
        [self loadTimeToFlapItsWingsInUpdates];
        self.soundSourceObject.audioLooping = AL_TRUE;

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
        [scene_object playSound];
        //Animacion: igual no hace falta el remove
        [self.sceneObjectDestroyer markToRemoveSceneObject:scene_object];
        //sumar a marcador "número de pájaros muertos"
        [self.scoreTransmitter aNewBirdIsKilled];
        [self.transformationController spawnFeathersFrom:(MGBird *)scene_object WithColor:BIRD_COLOR];
    }
}

- (void)loadTimeToFlapItsWingsInUpdates {
    timeToFlapItsWingsInUpdates = (TIME_TO_FLAP_ITS_WINGS * MAXIMUM_FRAME_RATE) * (self.speed.x * self.movingDirection);
}

- (void)flapItsWings {
    if (wingsDown) {
        self.mesh = self.downWingsQuad;
    }
    else {
        self.mesh = self.upWingsQuad;
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
        if (!self.taken) {
            timeToFlapItsWingsInUpdates--;
            if (timeToFlapItsWingsInUpdates <= 0) {
                [self flapItsWings];
                wingsDown = !wingsDown;
                [self loadTimeToFlapItsWingsInUpdates];
                
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
            if ([newTouches count] == 0) {
                takenTimeWithoutMovingInUpdates--;
                if (takenTimeWithoutMovingInUpdates <= 0) {
                    self.taken = NO;
                    self.finger.isFree = YES;
                    [self start];
                    [self loadTakenTimeWithoutMovingInUpdates];
                }
            }
            else {
                for (MGTouch *atouch in newTouches) {
                    if (atouch.phase == UITouchPhaseMoved) {
                        if (atouch.location.x > GRASS_HEIGHT) {
                            self.translation = [self.sceneController.inputViewController meshCenterFromMGTouchLocation:atouch.location];
                        }
                    }
                    else if (atouch.phase == UITouchPhaseEnded){
                        self.taken = NO;
                        self.finger.isFree = YES;
                        [self start];
                    }
                }
                [self loadTakenTimeWithoutMovingInUpdates];
            }
        }
    }
    [super update];
}


- (void)loadTakenTimeWithoutMovingInUpdates {
        takenTimeWithoutMovingInUpdates = TAKEN_TIME_WITHOUT_MOVING * MAXIMUM_FRAME_RATE;
}

- (void)playSound {
    [self.soundSourceObject playSound:[[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:TRANSFORMER_FLYING]];
}



+ (void)loadResources{
    [[MGOpenALSoundController sharedSoundController] soundBufferDataFromFileBaseName:TRANSFORMER_FLYING];
}

- (void)dealloc {
    [_scoreTransmitter release];
    [_tranformationController release];
    [_sceneObjectDestroyer release];
    [_finger release];
    [_upWingsQuad release];
    [_downWingsQuad release];
    [super dealloc];
}

@end
