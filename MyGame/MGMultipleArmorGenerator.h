//
//  MGArmorGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGGenerator.h"

#import "MGArmor.h"

@class MGSceneController;

@interface MGMultipleArmorGenerator : NSObject <MGGenerator> {
    NSMutableArray *_sceneObjects;
    MGSceneController *_sceneController;
    MGBoundaryController *_boundaryController;    
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, retain) NSMutableArray *sceneObjects;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjects:(NSMutableArray *)scene_objects;

@end