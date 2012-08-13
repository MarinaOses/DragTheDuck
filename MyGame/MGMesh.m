//
//  MGMesh.m
//  MyGame
//
//  Created by Marina Osés Merino on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMesh.h"

#define COLLIDER_VERTEX_COUNT 20
#define VERTEX_COUNT 4

@interface MGMesh()
- (MGPoint)calculateCentroid;
- (CGFloat)calculateRadiusWith:(MGPoint)mesh_centroid;
@end


@implementation MGMesh

@synthesize vertexes;
@synthesize colors; 
@synthesize colorSize; 
@synthesize vertexCount;
@synthesize vertexSize; 
@synthesize renderStyle;
@synthesize centroid;
@synthesize radius;

- (id)initWithVertexes:(GLfloat *)vert vertexCount:(NSInteger)vertCount vertexSize:(NSInteger)vertSize renderStyle:(GLenum)style {
    self = [super init];
    if (self != nil) {
        self.vertexes = vert;
        self.vertexCount = vertCount;
        self.vertexSize = vertSize;
        self.renderStyle = style;
        //centroid representa el centro de la esfera que recubre al objeto (collider)
        self.centroid = [self calculateCentroid];
        //radius representa la máxima distancia que puede obtenerse entre uno de los vértices del objeto y el centroide
        self.radius = [self calculateRadiusWith:self.centroid];
        
    }
    return self;
}

//Se calcula la media de todos los vértices
- (MGPoint)calculateCentroid {
    CGFloat xTotal = 0;
    CGFloat yTotal = 0;
    CGFloat zTotal = 0;
    //index marca la posición en la que empieza el vértice en el array.
    NSInteger index;
    for (index = 0; index < self.vertexCount; index++) {
        NSInteger position = index * self.vertexSize;
        xTotal += self.vertexes[position];
        yTotal += self.vertexes[position + 1];
        if (vertexSize > 2) {
            zTotal += self.vertexes[position + 2];
        }
    }
    return MGPointMake(xTotal/(CGFloat)self.vertexCount, yTotal/(CGFloat)self.vertexCount, zTotal/(CGFloat)self.vertexCount);
}


- (CGFloat)calculateRadiusWith:(MGPoint)mesh_centroid {
    CGFloat rad = 0.0;
    NSInteger index;
    for (index = 0; index < self.vertexCount; index++) {
        NSInteger position = index * self.vertexSize;
        MGPoint vert;
        if (self.vertexSize > 2) {
            vert = MGPointMake(self.vertexes[position], self.vertexes[position+1], self.vertexes[position+2]);
        }
        else {
            vert = MGPointMake(self.vertexes[position], self.vertexes[position+1], 0.0);
        }
        CGFloat thisRadius = MGPointDistance(mesh_centroid, vert);
        if (rad < thisRadius) {
            rad = thisRadius;
        }
    }
    return rad;
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
    for (index = 0; index < aMesh.vertexCount; index++) {
        NSInteger position = index * aMesh.vertexSize;
        //NSLog(@"x=%f y=%f",aMesh.vertexes[position] * aScale.x, aMesh.vertexes[position + 1] * aScale.y);
       
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

- (void)setColors:(GLfloat *)new_colors {
    if (colors != new_colors) {
        NSInteger colorsCount = self.vertexCount * self.colorSize;
        if (colors == nil) {
            colors = (CGFloat *)malloc(colorsCount * sizeof(CGFloat));    
        }
        NSInteger i;
        for (i = 0; i < colorsCount; i++) {
            colors[i] = new_colors[i]; 
        }
    }
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
    glDrawArrays(self.renderStyle, 0, self.vertexCount);
}


- (void)dealloc {
    free(colors);
    [super dealloc];
}
@end
