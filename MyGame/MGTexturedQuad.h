//
//  MGTexturedQuad.h
//  MyGame
//
//  Created by Marina Osés Merino on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMesh.h"
#import "MGMaterialController.h"


@interface MGTexturedQuad : MGMesh {
    GLfloat *uvCoordinates;
    NSString *_materialKey;
}

@property (nonatomic, retain) NSString *materialKey;
@property (nonatomic, assign) CGFloat *uvCoordinates;

- (id)initWithVertexes:(GLfloat *)vertexes_from_texture;

@end
