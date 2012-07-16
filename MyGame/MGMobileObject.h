//
//  MGMobileObject.h
//  MyGame
//
//  Created by Marina Osés Merino on 07/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneObject.h"
#import "MGBoundaryController.h"

@class MGSceneController;

@interface MGMobileObject : MGSceneObject {
    MGPoint _speed;
    NSInteger movingDirection;
    MGBoundaryController *_boundaryController;
}

@property (nonatomic, assign) MGPoint speed;
@property (nonatomic, retain) MGBoundaryController *boundaryController;
@property (nonatomic, assign) NSInteger movingDirection;

- (id)initWithSceneController:(MGSceneController *)scene_controller BoundaryController:(MGBoundaryController *)boundary_controller RangeForScale:(NSRange)scale_range RangeForSpeed:(NSRange)speed_range Direction:(int)direction;
- (MGPoint)randomScaleInRange:(NSRange)scale_range;
- (MGPoint)randomTranslationWithMeshBounds:(CGRect)mesh_bounds OnSide:(int)side;
- (MGPoint)randomSpeedInRange:(NSRange)speed_range WithDirection:(int)direction;
- (void)stop;
@end
