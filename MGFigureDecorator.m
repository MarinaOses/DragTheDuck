//
//  MGFigureDecorator.m
//  MyGame
//
//  Created by Marina Osés Merino on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGFigureDecorator.h"

static NSInteger MGFigureVertexSize = 2;
static NSInteger MGFigureColorSize = 4;
static GLenum MGFigureRenderStyle = GL_TRIANGLE_STRIP;
static NSInteger MGFigureVertexCount = 4;
static CGFloat MGFigureVertexes[8] = {
    -0.5, -0.5, 
    0.5, -0.5,
    -0.5, 0.5,
    0.5, 0.5
};

static CGFloat RGBAOfFigure[40] = {
    255.0, 64.0, 64.0, 255.0,
    162.0, 188.0, 19.0, 255.0,
    238.0, 201.0, 0.0, 255.0,
    176.0, 23.0, 31.0, 255.0,
    0.0, 154.0, 205.0, 255.0,
    238.0, 118.0, 0.0, 255.0,
    188.0, 233.0, 55.0, 255.0,
    238.0, 180.0, 34.0, 255.0,
    191.0, 95.0, 255.0, 255.0,
    11.0, 181.0, 255.0, 255.0
};

@implementation MGFigureDecorator
@synthesize RGBAColors;
@synthesize sceneController = _sceneController;

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        self.RGBAColors =  RGBAOfFigure;
        
        self.sceneController = scene_controller;
        
    }
    return self;
}

- (MGSceneObject *)createFigureWithValue:(NSString *)string_value { 
    if (string_value != nil) {
        NSInteger value = [string_value integerValue];
        if ([MGValidator isCorrect:value]) {
            MGSceneObject *newFigure = [[MGSceneObject alloc] initWithSceneController:self.sceneController];
            MGMesh *meshToAssign = [[MGMesh alloc] initWithVertexes:MGFigureVertexes vertexCount:MGFigureVertexCount vertexSize:MGFigureVertexSize renderStyle:MGFigureRenderStyle];
            newFigure.mesh = meshToAssign;
            [meshToAssign release];
            newFigure.mesh.colorSize = MGFigureColorSize;
            NSInteger position = value * MGFigureColorSize;
            newFigure.mesh.colors = [MGColorGenerator createColorWithSize:MGFigureColorSize ForNumberOfVertexes:MGFigureVertexCount WithRed:self.RGBAColors[position] green:self.RGBAColors[position+1] blue:self.RGBAColors[position+2] alpha:RGBAColors[position+3]];
            newFigure.isANumber = YES;
            return [newFigure autorelease];
        }
        else {
            NSLog(@"Aviso: el valor para la cifra no es el adecuado.");
            return nil;
        }
    }
    NSLog(@"Aviso: el parámetro string_value apunta a una dirección vacía");
    return nil;
}

- (void)dealloc {
    [_sceneController release];
    [super dealloc];
}

@end
