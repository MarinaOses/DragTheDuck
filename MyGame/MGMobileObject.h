//
//  MGMobileObject.h
//  MyGame
//
//  Created by Marina Osés Merino on 07/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#import "MGSceneObject.h"
#import "MGSceneObjectDestroyer.h"

@class MGSceneController;

@interface MGMobileObject : MGSceneObject {
    MGPoint _speed;
    MGSceneObjectDestroyer *_sceneObjectDestroyer;
}

@property (nonatomic, assign) MGPoint speed;
@property (nonatomic, retain) MGSceneObjectDestroyer *sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer RangeForScale:(NSRange)scale_range RangeForSpeed:(NSRange)speed_range Direction:(int)direction;
- (MGPoint)randomScaleInRange:(NSRange)scale_range;
- (MGPoint)randomTranslationOnSide:(int)side;
- (MGPoint)randomSpeedInRange:(NSRange)speed_range WithDirection:(int)direction;

@end
