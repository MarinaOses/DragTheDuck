//
//  MultipleBirdGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGConfiguration.h"
#import "MGBird.h"
#import "MGGenerator.h"

@class MGSceneController;

@interface MGMultipleBirdGenerator : NSObject <MGGenerator>{
    MGSceneController *_sceneController;
    MGBoundaryController *_boundaryController;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
}

@property (nonatomic, retain) MGSceneController *sceneController;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;


@end
