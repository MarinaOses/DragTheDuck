//
//  MGMultipleNestGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGConfiguration.h"
#import "MGNest.h"
#import "MGGenerator.h"
#import "MGTransformationController.h"
#import "MGFinger.h"

@class MGSceneController;

@interface MGMultipleNestGenerator : NSObject <MGGenerator> {
    MGSceneController *_sceneController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGScoreTransmitter *_scoreTransmitter;
    MGTransformationController *_transformationController;
    MGBoundaryController *_boundaryController;
    MGFinger *_finger;
    NSMutableArray *_sceneObjects;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGTransformationController *transformationController;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, retain) MGFinger *finger;
@property (nonatomic, retain) NSMutableArray *sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter SceneObjects:(NSMutableArray *)scene_objects;

@end
