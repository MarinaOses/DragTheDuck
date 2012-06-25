//
//  MGArmour.h
//  MyGame
//
//  Created by Marina Osés Merino on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGDuck.h"

@class MGSceneController;


@interface MGArmor : MGMobileObject

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller ToPutItOnDuck:(MGDuck *)duck;

@end
