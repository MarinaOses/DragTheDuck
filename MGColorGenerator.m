//
//  RGBAColorGenerator.m
//  MyGame
//
//  Created by Marina Osés Merino on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGColorGenerator.h"

#define RGBA 4 


@implementation MGColorGenerator



- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

//Crea el tipo de dato adecuado para poder ser asignado al mesh directamente (CGFloat *)
+ (CGFloat *)createColorWithSize:(NSInteger)color_size ForNumberOfVertexes:(NSInteger)vertex_count WithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    CGFloat *color;
    NSInteger vert;
    for (vert = 0; vert < vertex_count; vert++) {
        NSInteger position = vert * color_size;
        color[position] = r/255.0;
        color[position+1] = g/255.0;
        color[position+2] = b/255.0;
        if (color_size == RGBA) {
            color[position+3] = a/255.0;
        }
    }
    return color;
}

- (void)dealloc {
    [super dealloc];
}

@end
