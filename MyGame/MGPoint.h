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

static inline MGPoint MGPointMatrixMultiply(CGFloat *m, MGPoint p) {
    CGFloat x = p.x*m[0] + p.y*m[4] + p.z*m[8] + m[12];
    CGFloat y = p.x*m[1] + p.y*m[5] + p.z*m[9] + m[13];
    CGFloat z = p.x*m[2] + p.y*m[6] + p.z*m[10] + m[14];
    return (MGPoint) {x, y, z};
}

static inline CGFloat MGPointDistance(MGPoint p1, MGPoint p2) {
    return sqrt((p1.x - p2.x) * (p1.x - p2.x) +
                (p1.y - p2.y) * (p1.y - p2.y) +
                (p1.z - p2.z) * (p1.x - p2.z));
}

#endif
