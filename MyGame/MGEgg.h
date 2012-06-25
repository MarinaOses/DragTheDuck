//
//  MGEgg.h
//  MyGame
//
//  Created by Marina Osés Merino on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGDuck.h"

@interface MGEgg : MGMobileObject


- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller DropsFromKilledDuck:(MGDuck *)duck;
@end
