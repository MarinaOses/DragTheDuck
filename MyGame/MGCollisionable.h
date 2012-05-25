//
//  MGCollisionable.h
//  MyGame
//
//  Created by Marina Osés Merino on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGCollisionable <NSObject>
@required
- (void)collideWith:(MGSceneObject *)scene_object;

@end
