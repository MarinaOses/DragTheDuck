//
//  MGMaterialController.m
//  MyGame
//
//  Created by Marina Osés Merino on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMaterialController.h"

#import "MGTexturedQuad.h"

@interface MGMaterialController()
- (void)loadAtlasData:(NSString *)atlas_name;
@end

@implementation MGMaterialController
@synthesize materialLibrary = _materialLibrary;
@synthesize quadLibrary = _quadLibrary;



+ (MGMaterialController *)sharedMaterialController {
    static MGMaterialController *sharedMaterialController;
    @synchronized(self) {
        if (!sharedMaterialController) {
            sharedMaterialController = [[MGMaterialController alloc] init];
        }
    }
    return sharedMaterialController;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        _materialLibrary = [[NSMutableDictionary alloc] init];
        _quadLibrary = [[NSMutableDictionary alloc] init];
        [self loadAtlasData:@"mapa"];

    }
    return self;
}


- (CGSize)loadTextureImage:(NSString *)image_name MaterialKey:(NSString *)material_key {
    CGContextRef contextRef; //Hace referencia a la imagen
    GLubyte *imageData; //Buffer temporal para almacenar los datos de la imagen
    size_t width;
    size_t height;
    GLuint textureID; //El último ID para la textura
    
    UIImage *uiImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:image_name ofType:nil]];
    CGImageRef imageRef = [uiImage CGImage];
    width = CGImageGetWidth(imageRef);
    height = CGImageGetHeight(imageRef);
  
    CGSize imageSize = CGSizeMake(width, height);
    
    if (imageRef) {
        imageData = (GLubyte *)malloc(width * height * 4);
        contextRef = CGBitmapContextCreate(imageData, width, height, 8, width * 4, CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast);
        CGContextDrawImage(contextRef, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), imageRef);
        CGContextRelease(contextRef);
        glGenTextures(1, &textureID); //openGL nos deja el identificador de esa textura en la dirección pasada por parámetro
        glBindTexture(GL_TEXTURE_2D, textureID);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
        //release the image data
        free(imageData);
        //Se especifica el tipo de filtrado que se debe hacer cuando la textura se agranda
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        //o se estrecha
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

        //GL_LINEAR produce un efecto de suavizado
        //GL_NEAREST intenta producir el mismo efecto pero con mayor rapidez, de modo que en ocasiones pueden aparecer
        //cuadros inesperados
        
        //activar el uso de texturas 2D
        glEnable(GL_TEXTURE_2D);
        //set a blending function to use
        //glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        //enable blending
        //glEnable(GL_BLEND);


    }
    else {
        NSLog(@"no texture");
        return CGSizeZero;
    }
    [uiImage release];
    [self.materialLibrary setObject:[NSNumber numberWithUnsignedInt:textureID] forKey:material_key];
    return imageSize;
}

- (void)bindMaterial:(NSString *)material_key {
    NSNumber *numberObj = [self.materialLibrary objectForKey:material_key];
    if (numberObj != nil) {
        GLuint textureID = [numberObj unsignedIntValue];
        glEnable(GL_TEXTURE_2D);
        glBindTexture(GL_TEXTURE_2D, textureID);
    }
}

- (MGTexturedQuad *)texturedQuadFromAtlasRecord:(NSDictionary *)record AtlasSize:(CGSize)atlas_size MaterialKey:(NSString *)material_key {
    MGTexturedQuad *quad = [[MGTexturedQuad alloc] init];
    CGRect rect = CGRectFromString([record objectForKey:@"rect"]);
    CGFloat uMin = rect.origin.x / atlas_size.width;
    CGFloat vMin = rect.origin.y / atlas_size.height;
    CGFloat uMax = (rect.origin.x + rect.size.width) / atlas_size.width;
    CGFloat vMax = (rect.origin.y + rect.size.height) / atlas_size.height;
    
    quad.uvCoordinates[0] = uMin;
    quad.uvCoordinates[1] = vMax;
    
    quad.uvCoordinates[2] = uMax;
    quad.uvCoordinates[3] = vMax;
    
    quad.uvCoordinates[4] = uMin;
    quad.uvCoordinates[5] = vMin;
    
    quad.uvCoordinates[6] = uMax;
    quad.uvCoordinates[7] = vMin;
    
    quad.materialKey = material_key; 
    return [quad autorelease];
}



//cargar el atlas y preparar las texturas
- (void)loadAtlasData:(NSString *)atlas_name {
    NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
    CGSize atlasSize = [self loadTextureImage:[atlas_name stringByAppendingPathExtension:@"png"] MaterialKey:atlas_name];
    NSArray *itemData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:atlas_name ofType:@"plist"]];
    for (NSDictionary *record in itemData) {
        MGTexturedQuad *quad = [self texturedQuadFromAtlasRecord:record AtlasSize:atlasSize MaterialKey:atlas_name];
        [self.quadLibrary setObject:quad forKey:[record objectForKey:@"name"]];
    }
    [self bindMaterial:atlas_name];
    [apool release];
}

- (MGTexturedQuad *)quadFromKey:(NSString *)key {
    return [self.quadLibrary objectForKey:key];
}

- (void)dealloc {
    [_materialLibrary release];
    [_quadLibrary release];
    [super dealloc];
}

@end
