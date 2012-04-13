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


@interface MGMesh : NSObject {
    GLfloat *vertexes;
    GLfloat *_colors;
    
    GLenum renderStyle;
    NSInteger vertexCount;
    NSInteger vertexSize;
    NSInteger _colorSize;
}


@property (nonatomic, assign) GLfloat *colors;
@property (nonatomic, assign) NSInteger colorSize;

- (id)initWithVertexes:(GLfloat *)vert vertexCount:(NSInteger)vertCount vertexSize:(NSInteger)vertSize renderStyle:(GLenum)style;
- (void)render;

@end
