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
    GLfloat *_vertexes;
    GLfloat *_colors;
    
    GLenum _renderStyle;
    NSInteger _vertexCount;
    NSInteger _vertexSize;
    NSInteger _colorSize;
}

@property (nonatomic, assign) GLfloat *vertexes;
@property (nonatomic, assign) GLfloat *colors;
@property (nonatomic, assign) NSInteger colorSize;
@property (nonatomic, assign) NSInteger vertexCount;
@property (nonatomic, assign) NSInteger vertexSize;
@property (nonatomic, assign) GLenum renderStyle;

- (id)initWithVertexes:(GLfloat *)vert vertexCount:(NSInteger)vertCount vertexSize:(NSInteger)vertSize renderStyle:(GLenum)style;
- (void)render;
+ (CGRect)boundsOf:(MGMesh *)aMesh WithScale:(MGPoint)aScale;


@end
