//
//  MGTransformer.h
//  MyGame
//
//  Created by Marina Osés Merino on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"
#import "MGCollisionable.h"
#import "MGScoreTransmitter.h"

@class MGSceneController;
@class MGTransformationController;

@interface MGTransformer : MGMobileObject <MGCollisionable> {
    MGScoreTransmitter *_scoreTransmitter;
    MGTransformationController *_tranformationController;
}

@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGTransformationController *transformationController;


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTransmitter:(MGScoreTransmitter *)score_transmitter TransformationController:(MGTransformationController *)transformation_controller StartAtPoint:(MGPoint)start_point;
@end
