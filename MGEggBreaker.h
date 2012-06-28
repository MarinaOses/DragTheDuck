//
//  MGEggBreaker.h
//  MyGame
//
//  Created by Marina Osés Merino on 28/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGBrokenEgg.h"


@class MGLifesController;

@interface MGEggBreaker : NSObject {
    MGSceneController *_sceneController;
    MGBoundaryController *_boundaryController;
    MGLifesController *_lifesController;
    NSMutableArray *_sceneObjects;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, retain) MGLifesController *lifesController;
@property (nonatomic, retain) NSMutableArray *sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller LifesController:(MGLifesController *)lifes_controller SceneObjects:(NSMutableArray *)scene_objects;

- (void)breakEgg:(MGEgg *)egg;

@end
