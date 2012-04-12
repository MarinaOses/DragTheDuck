//
//  EAGLView.h
//  MyGame
//
//  Created by Marina Osés Merino on 16/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "MGConfiguration.h"

@interface EAGLView : UIView {
// A todo lo declarado hasta el @end solo se puede acceder a través instancias de la misma clase    
@private
    
    //guarda las dimensiones de la pantalla
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    //Framebuffer almacena toda la información sobre la imagen que va salir por pantalla
    //Backbuffer o renderbuffer es donde se dibuja antes de mostrar la imagen
    //Depthbuffer almacena información sobre la profundidad de los píxeles, determinando qué pixeles están delante y cuales detrás
    
    GLuint viewRenderBuffer;
    GLuint viewFrameBuffer;
    GLuint depthRenderBuffer;
    
}

- (void)beginDraw;
- (void)finishDraw;
@end
