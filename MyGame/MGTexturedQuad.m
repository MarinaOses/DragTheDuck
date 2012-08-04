//
//  MGTexturedQuad.m
//  MyGame
//
//  Created by Marina Osés Merino on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGTexturedQuad.h"

static CGFloat MGTexturedQuadVertexes[8] = {
    -0.5, -0.5,
    0.5, -0.5,
    -0.5, 0.5,
    0.5, 0.5
};

static CGFloat MGTexturedQuadColorValues[16] = {
    1.0, 1.0, 1.0, 1.0,
    1.0, 1.0, 1.0, 1.0,
    1.0, 1.0, 1.0, 1.0,
    1.0, 1.0, 1.0, 1.0
};

static NSInteger MGTexturedQuadVertexSize = 2;
static NSInteger MGTexturedQuadVertexCount = 4;
static GLenum MGTexturedQuadRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger MGTexturedQuadColorSize = 4;

@implementation MGTexturedQuad
@synthesize materialKey = _materialKey;
@synthesize uvCoordinates;


- (id)init {
    self = [super initWithVertexes:MGTexturedQuadVertexes vertexCount:MGTexturedQuadVertexCount vertexSize:MGTexturedQuadVertexSize renderStyle:MGTexturedQuadRenderStyle];
    if (self != nil) {
        uvCoordinates = (CGFloat *)malloc(8 * sizeof(CGFloat)); 
        self.colors = MGTexturedQuadColorValues;
        self.colorSize = MGTexturedQuadColorSize;
    }
    return self;
}

- (void)render {
    //Cargar los arrays en OpenGLES
    //Stride (0) especifica el número de bytes que se han dejado entre vertices consecutivos del array 
    glVertexPointer(self.vertexSize, GL_FLOAT, 0, self.vertexes);
    glEnableClientState(GL_VERTEX_ARRAY);
    glColorPointer(self.colorSize, GL_FLOAT, 0, self.colors);
    glEnableClientState(GL_COLOR_ARRAY);
    
    if (self.materialKey != nil) {
        [[MGMaterialController sharedMaterialController] bindMaterial:self.materialKey];
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glTexCoordPointer(2, GL_FLOAT, 0, self.uvCoordinates);
        
    }
    
    //dibujar
    glDrawArrays(self.renderStyle, 0, self.vertexCount);
    glFlush();
    glDisable(GL_TEXTURE_2D);
}

- (void)dealloc {
    [_materialKey release];
    [super dealloc];
}

@end
