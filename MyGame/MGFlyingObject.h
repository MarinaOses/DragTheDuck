//
//  MGFlyingObject.h
//  MyGame
//
//  Created by Marina Osés Merino on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGFlyingObject <NSObject>
@required
- (void)flapItsWings;
- (void)loadTimeToFlapItsWingsInUpdates;

@end
