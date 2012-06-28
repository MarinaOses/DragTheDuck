//
//  MGBrokenEgg.h
//  MyGame
//
//  Created by Marina Osés Merino on 27/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGEgg.h"

@class MGLifesController;

@interface MGBrokenEgg : MGMobileObject {
    MGLifesController *_lifesController;
    MGPoint finishingPoint;
    NSInteger fallingDirection;
}

@property (nonatomic, retain) MGLifesController *lifesController;


- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller  LifesController:(MGLifesController *)lifes_controller ComesFromEgg:(MGEgg *)egg;

@end
