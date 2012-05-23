//
//  MGPoint.h
//  MyGame
//
//  Created by Marina Osés Merino on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MyGame_MGPoint_h
#define MyGame_MGPoint_h

typedef struct {
    CGFloat x, y, z;
}MGPoint;

typedef MGPoint *MGPointPtr;

static inline MGPoint MGPointMake(CGFloat x, CGFloat y, CGFloat z) {
    return (MGPoint) {x, y, z};
}

static inline MGPoint MGPointZero(){
    return (MGPoint) {0.0, 0.0, 0.0};
}


#endif
