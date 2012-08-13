//
//  MGDuck.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"
#import "MGCollisionable.h"
#import "MGScoreTransmitter.h"
#import "MGFinger.h"
#import "MGFlyingObject.h"



@class MGSceneController;
@class MGTransformationController;

@interface MGDuck : MGMobileObject <MGCollisionable, MGFlyingObject>{
    MGScoreTransmitter *_scoreTransmitter;
    BOOL draggeable;
    BOOL taken;
    MGTransformationController *_transformationController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGFinger *_finger;
    BOOL takenNest;
    NSInteger takenTimeWithoutMovingInUpdates;
    BOOL wingsDown;
    NSInteger timeToFlapItsWingsInUpdates;
    MGTexturedQuad *_upWingsQuad;
    MGTexturedQuad *_downWingsQuad;
}


@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, assign) BOOL draggeable;
@property (nonatomic, assign) BOOL taken;
@property (nonatomic, retain) MGTransformationController *transformationController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGFinger *finger;
@property (nonatomic, assign) BOOL wingsDown;
@property (nonatomic, retain) MGTexturedQuad *downWingsQuad;
@property (nonatomic, retain) MGTexturedQuad *upWingsQuad;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter TransformationController:(MGTransformationController *)transformation_controller TouchFinger:(MGFinger *)touch_finger AppearanceHeight:(CGFloat)appearance_height;



@end
