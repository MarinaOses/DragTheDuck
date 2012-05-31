//
//  MGTakenLeavesButtonShowerLayer.h
//  MyGame
//
//  Created by Marina Osés Merino on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"
#import "MGSceneObjectDestroyer.h"

@interface MGTakenLeavesButtonShowerLayer : MGSceneObject {
    CGFloat heightToDecrease;
    
}

- (id)initWithSceneController:(MGSceneController *)scene_controller Translation:(MGPoint)shower_translation Rotation:(MGPoint)shower_rotation Scale:(MGPoint)shower_scale;
- (void)decreaseHeight:(NSInteger)leaves_left;
@end
