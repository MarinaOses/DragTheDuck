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

@interface MGTransformer : MGMobileObject <MGCollisionable> {
    MGScoreTransmitter *_scoreTransmitter;
    MGTransformationController *_tranformationController;
    NSInteger lifeTimeInUpdates;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGFinger *_finger;
    BOOL taken;
}

@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGTransformationController *transformationController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGFinger *finger;
@property (nonatomic, assign) BOOL taken;


- (id)initWithDuck:(MGDuck *)duck;
@end
