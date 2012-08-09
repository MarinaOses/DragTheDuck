//
//  MGBoundaryController.m
//  MyGame
//
//  Created by Marina Osés Merino on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGBoundaryController.h"

#import "MGSceneController.h"
#import "MGMobileObject.h"
#import "MGEggBreaker.h"

@implementation MGBoundaryController
@synthesize sceneController = _sceneController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize eggBreaker = _eggBreaker;
@synthesize lifesController = _lifesController;
@synthesize sceneObjects = _sceneObjects;


- (id)initWithSceneController:(MGSceneController *)scene_controller ScoreTransmitter:(MGScoreTransmitter *)score_transmitter SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer LifesController:(MGLifesController *)lifes_controller SceneObjects:(NSMutableArray *)scene_objects {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.scoreTransmitter = score_transmitter;
        self.lifesController = lifes_controller;
        self.sceneObjects = scene_objects;
    }
    return self;
}

- (void)createEggBreaker {
    _eggBreaker = [[MGEggBreaker alloc] initWithSceneController:self.sceneController BoundaryController:self LifesController:self.lifesController SceneObjects:self.sceneObjects];
}


- (void)checkIfItIsOutOfBondaries:(MGMobileObject *)mobile_object {
    BOOL outOfBoundaries = NO;
    CGFloat midYOfWindowRect = CGRectGetMidY(self.sceneController.openGLView.window.frame);
    CGFloat midYOfMeshRect = CGRectGetMidY(mobile_object.meshBounds);
    CGFloat midXOfWindowRect = CGRectGetMidX(self.sceneController.openGLView.window.frame);
    CGFloat midXOfMeshRect = CGRectGetMidX(mobile_object.meshBounds);
    CGFloat centerX = mobile_object.translation.x;
    CGFloat centerY = mobile_object.translation.y;
    
    if (centerX > (midYOfWindowRect + midXOfMeshRect)) { //Derecha
        outOfBoundaries = YES;    
    }   
    if (centerX < (-midYOfWindowRect - midXOfMeshRect)) { //Izquierda
        outOfBoundaries = YES;
    }
    
    if (centerY > (midXOfWindowRect + midYOfMeshRect)) { //Arriba
        outOfBoundaries = YES;
    }
    
    if (centerY < (-midXOfWindowRect + GRASS_HEIGHT - midYOfMeshRect)) { //Abajo
        outOfBoundaries = YES;
    }
    
    if (outOfBoundaries) {
        if ([mobile_object isKindOfClass:[MGDuck class]]) {
            MGDuck *duck = (MGDuck *)mobile_object;
            duck.finger.isFree = YES;
            if (centerX > (midYOfWindowRect + midXOfMeshRect)) { //Derecha
                [self.scoreTransmitter aNewDuckIsSaved];
                [self.sceneObjectDestroyer markToRemoveSceneObject:mobile_object];
            }
        }
        else if ([mobile_object isKindOfClass:[MGTransformer class]]) {
            MGTransformer *transformer = (MGTransformer *)mobile_object;
            transformer.finger.isFree = YES;
            if (centerX > (midYOfWindowRect + midXOfMeshRect)) { //Derecha
                [self.scoreTransmitter theTransformerHasCrossedTheLine];
                [self.sceneObjectDestroyer markToRemoveSceneObject:mobile_object];
            }

        }
        else if ([mobile_object isKindOfClass:[MGBird class]] || [mobile_object isKindOfClass:[MGArmor class]]) {
            [self.sceneObjectDestroyer markToRemoveSceneObject:mobile_object];

        }
        else if ([mobile_object isKindOfClass:[MGEgg class]]) {
            [self.eggBreaker breakEgg:(MGEgg *)mobile_object];
            [self.sceneObjectDestroyer markToRemoveSceneObject:mobile_object];
        }
        else { //BrokenEgg
            
        }
    }
}

- (BOOL)hasTheNest:(MGNest *)nest arrivedToPointX:(CGFloat)point_x {
    BOOL hasArrived = NO;
    if (nest.translation.x >= point_x) {
        hasArrived = YES;
    }
    return hasArrived;
}

- (void)checkIf:(MGMobileObject *)mobile_object HasArrivedTo:(MGPoint)point FallingInDirection:(NSInteger)direction {
    if (MGPointHasCrossedMGPointInDirection(mobile_object.translation, point, direction)) {
        [self.sceneObjectDestroyer markToRemoveSceneObject:mobile_object];
        [self.lifesController aLifeHasBeenSpent];
    }
}


- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [_scoreTransmitter release];
    [_eggBreaker release];
    [_lifesController release];
    [_sceneObjects release];
    [super dealloc];
}

@end
