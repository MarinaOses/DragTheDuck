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


- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTransmitter:(MGScoreTransmitter *)score_transmitter TransformationController:(MGTransformationController *)transformation_controller StartAtPoint:(MGPoint)start_point {
    
    self = [super initWithSceneController:scene_controller BoundaryController:boundary_controller RangeForScale:NSMakeRange(MIN_TRANSFORMER_SCALE, MAX_TRANSFORMER_SCALE) RangeForSpeed:NSMakeRange(MIN_TRANSFORMER_SPEED, MAX_TRANSFORMER_SPEED) Direction:1];
    if (self) {
        self.mesh.colors = MGTransformerColorValues;
        self.translation = start_point;
        self.collider.checkForCollision = YES;
        self.scoreTransmitter = score_transmitter;
        self.transformationController = transformation_controller;
        lifeTimeInUpdates = (int) ([self randomLifeTime] * MAXIMUM_FRAME_RATE);
        self.sceneObjectDestroyer = scene_object_destroyer;
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
        NSSet *touchesSet = [self.sceneController.inputViewController touchEvents];
        for (MGTouch *atouch in touchesSet) {
            if (atouch.phase == UITouchPhaseBegan && atouch.numberOfFingersOnTheScreen == 1) {
                CGRect screenRectToAccess = self.screenRect;
                CGRect touchableArea = CGRectMake(CGRectGetMinX(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DUCKS, CGRectGetMinY(screenRectToAccess) - ADD_TO_SCREENRECT_OF_DUCKS, CGRectGetWidth(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DUCKS*2, CGRectGetHeight(screenRectToAccess) + ADD_TO_SCREENRECT_OF_DUCKS*2);
                if (CGRectContainsPoint(touchableArea, atouch.location)) {
                    taken = YES;
                }
            }
            else if (atouch.phase == UITouchPhaseMoved && taken == YES) {
                self.translation = [self.sceneController.inputViewController meshCenterFromMGTouchLocation:atouch.location];
            }
            else if (atouch.phase == UITouchPhaseEnded){
                taken = NO;
            }
        }
    }
    
    [super update];
}


- (void)dealloc {
    [_scoreTransmitter release];
    [_tranformationController release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}

@end
