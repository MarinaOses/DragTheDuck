//
//  MGMultipleDuckGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGConfiguration.h"
#import "MGDuck.h"
#import "MGGenerator.h"
#import "MGTransformationController.h"

@class MGSceneController;

@interface MGMultipleDuckGenerator : NSObject <MGGenerator> {
    MGSceneController *_sceneController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    MGScoreTransmitter *_scoreTransmitter;
    MGTransformationController *_transformationController;
    MGBoundaryController *_boundaryController;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;
@property (nonatomic, retain) MGScoreTransmitter *scoreTransmitter;
@property (nonatomic, retain) MGTransformationController *transformationController;
@property (nonatomic, retain) MGBoundaryController *boundaryController;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer ScoreTrasnmitter:(MGScoreTransmitter *)score_transmitter SceneObjects:(NSMutableArray *)scene_objects;

@end
