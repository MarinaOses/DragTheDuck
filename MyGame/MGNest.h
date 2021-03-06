//
//  MGNest.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGDuck.h"


@class MGSceneController;

@interface MGNest : MGMobileObject {
    BOOL taken;
    MGScoreTransmitter *_scoreTransmitter;
    MGTransformationController *_transformationController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    NSMutableArray *_sceneObjects;
    MGFinger *_finger;
    NSInteger timeBeforeTheDuckAppearsInUpdates;
    BOOL throwedDuck;
    MGDuck *_generatedDuck;
}

@property (nonatomic, assign) BOOL taken;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGTransformationController *transformationController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGFinger *finger;
@property (nonatomic, retain) MGDuck *generatedDuck;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter TransformationController:(MGTransformationController *)transformation_controller TouchFinger:(MGFinger *)touch_finger SceneObjects:(NSMutableArray *)scene_objects;

@end
