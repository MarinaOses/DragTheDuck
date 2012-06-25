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

@implementation MGBoundaryController
@synthesize sceneController = _sceneController;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize scoreTransmitter = _scoreTransmitter;


- (id)initWithSceneController:(MGSceneController *)scene_controller ScoreTransmitter:(MGScoreTransmitter *)score_transmitter SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super init];
    if (self) {
        self.sceneController = scene_controller;
        self.sceneObjectDestroyer = scene_object_destroyer;
        self.scoreTransmitter = score_transmitter;
    }
    return self;
}


- (void)checkIfItIsOutOfBondaries:(MGMobileObject *)mobile_object {
    BOOL outOfBoundaries = NO;
    CGFloat midYOfWindowRect = CGRectGetMidY(self.sceneController.openGLView.window.frame);
    CGFloat midYOfMeshRect = CGRectGetMidY(mobile_object.meshBounds);
    CGFloat midXOfWindowRect = CGRectGetMidX(self.sceneController.openGLView.window.frame);
    CGFloat midXOfMeshRect = CGRectGetMidX(mobile_object.meshBounds);
    CGFloat centerX = mobile_object.translation.x;
    CGFloat centerY = mobile_object.translation.y;
    
    if (centerX > (midYOfWindowRect + midXOfMeshRect)) {
        outOfBoundaries = YES;    
    }   
    if (centerX < (-midYOfWindowRect - midXOfMeshRect)) {
        outOfBoundaries = YES;
    }
    
    if (centerY > (midXOfWindowRect + midYOfMeshRect)) {
        outOfBoundaries = YES;
    }
    
    if (centerY < (-midXOfWindowRect - midYOfMeshRect)) {
        outOfBoundaries = YES;
    }
    
    if (outOfBoundaries) {
        if ([mobile_object isKindOfClass:[MGDuck class]]) {
            [self.scoreTransmitter aNewDuckIsSaved];
        }
        else if ([mobile_object isKindOfClass:[MGTransformer class]]) {
            [self.scoreTransmitter theTransformerHasCrossedTheLine];
        }
        [self.sceneObjectDestroyer markToRemoveSceneObject:mobile_object];
    }
}




- (void)dealloc {
    [_sceneController release];
    [_sceneObjectDestroyer release];
    [_scoreTransmitter release];
    [super dealloc];
}

@end
