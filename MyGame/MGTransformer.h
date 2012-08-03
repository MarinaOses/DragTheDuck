//
//  MGTransformer.h
//  MyGame
//
//  Created by Marina Osés Merino on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGDuck.h"
#import "MGCollisionable.h"
#import "MGScoreTransmitter.h"
#import "MGFinger.h"

@class MGSceneController;
@class MGTransformationController;

@interface MGTransformer : MGMobileObject <MGCollisionable, MGFlyingObject> {
    MGScoreTransmitter *_scoreTransmitter;
    MGTransformationController *_tranformationController;
    NSInteger lifeTimeInUpdates;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGFinger *_finger;
    BOOL taken;
    MGPoint savedSpeed;
    NSInteger takenTimeWithoutMovingInUpdates;
    BOOL wingsDown;
    NSInteger timeToFlapItsWingsInUpdates;
    MGTexturedQuad *_upWingsQuad;
    MGTexturedQuad *_downWingsQuad;
  
}

@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGTransformationController *transformationController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGFinger *finger;
@property (nonatomic, assign) BOOL taken;
@property (nonatomic, retain) MGTexturedQuad *upWingsQuad;
@property (nonatomic, retain) MGTexturedQuad *downWingsQuad;


- (id)initWithDuck:(MGDuck *)duck;
@end
