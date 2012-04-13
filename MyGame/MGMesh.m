//
//  MGMesh.m
//  MyGame
//
//  Created by Marina Osés Merino on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMesh.h"

@implementation MGMesh

@synthesize colors = _colors;
@synthesize colorSize = _colorSize;

- (id)initWithVertexes:(GLfloat *)vert vertexCount:(NSInteger)vertCount vertexSize:(NSInteger)vertSize renderStyle:(GLenum)style {
    self = [super init];
    if (self != nil) {
        vertexes = vert;
        vertexCount = vertCount;
        vertexSize = vertSize;
        renderStyle = style;
    }
    return self;
}

//Se llama una vez cada frame
- (void)render {
    //Cargar los arrays en OpenGLES
    //Stride (0) especifica el número de bytes que se han dejado entre vertices consecutivos del array 
    glVertexPointer(vertexSize, GL_FLOAT, 0, vertexes);
    glEnableClientState(GL_VERTEX_ARRAY);
    glColorPointer(self.colorSize, GL_FLOAT, 0, self.colors);
    glEnableClientState(GL_COLOR_ARRAY);
    
    //dibujar
    glDrawArrays(renderStyle, 0, vertexCount);
}

- (void)dealloc {
    [super dealloc];
}
@end
