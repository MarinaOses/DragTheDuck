//
//  MGMesh.m
//  MyGame
//
//  Created by Marina Osés Merino on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMesh.h"

@interface MGMesh()

- (MGPoint)calculateCentroid;

@end



@implementation MGMesh

@synthesize vertexes = _vertexes;
@synthesize colors = _colors;
@synthesize colorSize = _colorSize;
@synthesize vertexCount = _vertexCount;
@synthesize vertexSize = _vertexSize;

- (id)initWithVertexes:(GLfloat *)vert vertexCount:(NSInteger)vertCount vertexSize:(NSInteger)vertSize renderStyle:(GLenum)style {
    self = [super init];
    if (self != nil) {
        self.vertexes = vert;
        self.vertexCount = vertCount;
        self.vertexSize = vertSize;
        renderStyle = style;
        centroid = [self calculateCentroid];
    }
    return self;
}


+ (CGRect)boundsOf:(MGMesh *)aMesh WithScale:(MGPoint)aScale {
    CGRect boundsRect;
    //Si el parámetro mesh es nulo se devuelve un rectángulo cuya localización es (0,0) y tanto la altura como la anchura son 0
    if (aMesh == nil) {
        boundsRect = CGRectZero;
    }
    
    //Se calculan las coordenadas máximas y mínimas del objeto para crear el rectángulo que recoja todos lo vértices del objeto
    CGFloat xMin, xMax, yMin, yMax;
    //Se inicializan las variables con los valores de primer vértice
    xMin = xMax = aMesh.vertexes[0] * aScale.x;
    yMin = yMax = aMesh.vertexes[1] * aScale.y;
    
    //Se comienza desde el bloque 1 ya el primer bloque ha sido asignado en la inicialización anterior
    NSInteger index;
    for (index = 1; index < aMesh.vertexCount; index++) {
        NSInteger position = index * aMesh.vertexSize;
        CGFloat newValueForX = aMesh.vertexes[position] * aScale.x;
        CGFloat newValueForY = aMesh.vertexes[position + 1] * aScale.y;
        //Se actualizan los valores mínimos y máximos
        if (xMin > newValueForX) xMin = newValueForX;
        if (xMax < newValueForX) xMax = newValueForX;
        if (yMin > newValueForY) yMin = newValueForY;
        if (yMax < newValueForY) yMax = newValueForY;
    }
    //Se crea en rectángulo con los valores conseguidos
    boundsRect = CGRectMake(xMin, yMin, xMax - xMin, yMax - yMin);
    
    //La anchura o la altura del rectángulo creado no debe ser inferior a 1.0
    if (CGRectGetWidth(boundsRect) < 1.0) boundsRect.size.width = 1.0;
    if (CGRectGetHeight(boundsRect) < 1.0) boundsRect.size.height = 1.0;
    
    return boundsRect;
}


//Se llama una vez cada frame
- (void)render {
    //Cargar los arrays en OpenGLES
    //Stride (0) especifica el número de bytes que se han dejado entre vertices consecutivos del array 
    glVertexPointer(self.vertexSize, GL_FLOAT, 0, self.vertexes);
    glEnableClientState(GL_VERTEX_ARRAY);
    glColorPointer(self.colorSize, GL_FLOAT, 0, self.colors);
    glEnableClientState(GL_COLOR_ARRAY);
    
    //dibujar
    glDrawArrays(renderStyle, 0, self.vertexCount);
}

- (MGPoint)calculateCentroid {
    
}


- (void)dealloc {
    [super dealloc];
}
@end
