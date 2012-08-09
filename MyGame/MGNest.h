//
//  MGNest.h
//  MyGame
//
//  Created by Marina Osés Merino on 09/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMobileObject.h"
#import "MGFinger.h"


@class MGSceneController;

@interface MGNest : MGMobileObject {
    BOOL draggeable;
    BOOL taken;
    MGFinger *_finger;
    MGPoint savedSpeed;
}

@property (nonatomic, assign) BOOL draggeable;
@property (nonatomic, assign) BOOL taken;
@property (nonatomic, retain) MGFinger *finger;


@end
