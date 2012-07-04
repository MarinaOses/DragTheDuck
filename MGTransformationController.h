//
//  MGTransformationController.h
//  MyGame
//
//  Created by Marina Osés Merino on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGTransformer.h"
#import "MGBee.h"
#import "MGEgg.h"
#import "MGFeathers.h"

@class MGSceneController;


@interface MGTransformationController : NSObject {
    NSMutableArray *_sceneObjects;
    MGDuck *_duckWhoStartsTheTransformation;
    MGSceneController *_sceneController;
    MGBoundaryController *_boundaryController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
    
}

@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, retain) MGDuck *duckWhoStartsTheTransformation;
@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectsDestroyer:(MGSceneObjectDestroyer *)scene_objects_destroyer SceneObjects:(NSMutableArray *)scene_objects;
- (void)spawnBeeFrom:(MGDuck *)duck;
- (void)spawnDuckFrom:(MGTransformer *)transformer;
- (void)spawnEggFrom:(MGDuck *)killed_duck;
- (void)spawnFeathersFrom:(MGMobileObject *)killed_mobile_object;

@end
