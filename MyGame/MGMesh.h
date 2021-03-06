//
//  MGMesh.h
//  MyGame
//
//  Created by Marina Osés Merino on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>

#import "MGPoint.h"


@interface MGMesh : NSObject {
    GLfloat *vertexes;
    GLfloat *colors;
    
    GLenum renderStyle;
    NSInteger vertexCount;
    NSInteger vertexSize;
    NSInteger colorSize;
    
    MGPoint centroid;
    CGFloat radius;
}

@property (nonatomic, assign) GLfloat *vertexes;
@property (nonatomic, assign) GLfloat *colors;
@property (nonatomic, assign) NSInteger colorSize;
@property (nonatomic, assign) NSInteger vertexCount;
@property (nonatomic, assign) NSInteger vertexSize;
@property (nonatomic, assign) GLenum renderStyle;
@property (nonatomic, assign) MGPoint centroid;
@property (nonatomic, assign) CGFloat radius;


- (id)initWithVertexes:(GLfloat *)vert vertexCount:(NSInteger)vertCount vertexSize:(NSInteger)vertSize renderStyle:(GLenum)style;
- (void)render;
+ (CGRect)boundsOf:(MGMesh *)aMesh WithScale:(MGPoint)aScale;


@end
