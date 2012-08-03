//
//  MGBird.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"
#import "MGFlyingObject.h"


@class MGSceneController;

@interface MGBird : MGMobileObject <MGFlyingObject> {
    BOOL wingsDown;
    NSInteger timeToFlapItsWingsInUpdates;
    MGTexturedQuad *_upWingsQuad;
    MGTexturedQuad *_downWingsQuad;
}

@property (nonatomic, retain) MGTexturedQuad *upWingsQuad;
@property (nonatomic, retain) MGTexturedQuad *downWingsQuad;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer;
@end
