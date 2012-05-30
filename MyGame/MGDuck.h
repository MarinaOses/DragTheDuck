//
//  MGDuck.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"
#import "MGCollisionable.h"
#import "MGTakenLeavesButton.h"

@class MGSceneController;


@interface MGDuck : MGMobileObject <MGCollisionable> {
    MGTakenLeavesButton *_takenLeavesButton;
}


@property (nonatomic, retain) MGTakenLeavesButton *takenLeavesButton;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer takenLeavesButton:(MGTakenLeavesButton *)taken_leaves_button;

@end
