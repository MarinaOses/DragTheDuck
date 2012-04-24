//
//  EAGLView.m
//  MyGame
//
//  Created by Marina Osés Merino on 16/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>


#import "EAGLView.h"


//Al estar en el .m estamos creando una extensión de la interfaz EAGLView cuyos métodos serán privados
@interface EAGLView () 
//nonatomic -- no serializable. 
@property (nonatomic, retain) EAGLContext *context;

- (BOOL)didCreateFrameBuffer;
- (void)destroyFrameBuffer;

  
@end

@implementation EAGLView

@synthesize context;


//Marcador: esto nos permite devolver la clase que nosotros queramos. Como nosotros queremos renderizar en openGL necesitamos la clase CAEAGLLayer, totalmente compatible con todas las llamadas openGL. 
+ (Class)layerClass {
    return [CAEAGLLayer class];
}


- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];
    if (self) {
        // Marcador: self.layer devuelve el layer genérico de correspondiente a Core Animation de UIView. Este es el layer que se utiliza para dibujar cosas en la vista. Le hacemos el cast para decirle que se trata de un layer de openGL y no de uno de Core Animation.
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        eaglLayer.opaque = YES;
        
        //Marcador: numberWithBool devuelve un NSNumber asociado a ese valor booleano
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        //Marcador: el contexto almacena toda la información sobre el estado, comandos y todos los recursos necesarios para dibujar usando openGLES
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }
    }
    self.multipleTouchEnabled = YES;
    return self;
}

//Esta función ya no se utiliza
- (void)setupViewPortrait {
    //establece la porción de ventana en la que puede dibujar openGL
    glViewport(0, 0, backingWidth, backingHeight);
    //con esta función indicamos a cuál de los tres tipos de matrices (GL_PROJECTION, GL_MODELVIEW, GL_TEXTURE) van a afectar las operaciones de transformación. GL_PROJECTION afecta a las vistas. 
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    //establece una perspectiva ortonormal. Se mantienen las proporciones de la pantalla del iPhone (320x480 = 2x3)
    //El eje Z toma los objetos de la escena son en 2D
    glOrthof(-1.0f, 1.0f, -1.5f, 1.5f, -1.0f, 1.0f);
    //definir el color del fondo
    glMatrixMode(GL_MODELVIEW);
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
}


- (void)setupViewLandScape {
    //define la porción de ventana donde openGL puede dibujar, es decir, en toda la pantalla
    //Los dos primeros parámetros definen el punto horizontal y vertical de la esquina superior izquierda.
    //Los dos últimos definen el ancho y alto de la ventana
    glViewport(0, 0, backingWidth, backingHeight);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    //Simula un giro de 90 grados del dispositivo 
    glRotatef(-90.0f, 0.0f, 0.0f, 1.0f);
    //Se crea una analogía entre el viewport y los píxeles de la pantalla
    glOrthof(-backingHeight/2.0f, backingHeight/2.0f, -backingWidth/2.0f, backingWidth/2.0f, -1.0f, 1.0f);
    glMatrixMode(GL_MODELVIEW);
    //Se limpia la pantalla con gris
    glClearColor(0.5f, 0.5f, 0.5f, 0.0f);
    
}


- (void)beginDraw {
    //Para estar seguros de que estamos dibujando en el contexto actual
    [EAGLContext setCurrentContext:context];
    //Se une el frameBuffer a la variable correspondiente al mismo
    glBindFramebuffer(GL_FRAMEBUFFER_OES, viewFrameBuffer);
    //Se especifica que las siguientes llamadas de transformación de matrices se aplican sobre modelview matrix
    glMatrixMode(GL_MODELVIEW);
    //Limpiar el color buffer a sus corresponientes valores iniciales
    glClear(GL_COLOR_BUFFER_BIT);
    glLoadIdentity();
}


- (void)finishDraw {
    //Se une el renderBuffer con su variable correspondiente
    glBindRenderbuffer(GL_RENDERBUFFER_OES, viewRenderBuffer);
    //muestra el contenido de renderbuffer por pantalla
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}


- (void)layoutSubviews {
    //para estar seguros de que se esta trabajando sobre el contexto actual
    [EAGLContext setCurrentContext:context];
    //reinicia todos los buffers
    [self destroyFrameBuffer];
    //crea nuevos buffers: framebuffer, renderbuffer y depthbuffer
    if ([self didCreateFrameBuffer]) {
        //Si todo va bien establece la ventana de dibujo
        [self setupViewLandScape];
    }
}


- (BOOL)didCreateFrameBuffer {
    //viewFramebuffer y viewRenderBuffer almacenan el dentificador del buffer correspondiente
    glGenFramebuffersOES(1, &viewFrameBuffer);
    glGenRenderbuffersOES(1, &viewRenderBuffer);
    
    //Se unen los targets a sus correspondientes variables
    glBindFramebuffer(GL_FRAMEBUFFER_OES, viewFrameBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER_OES, viewRenderBuffer);
    
    //se une el almacén de objetos a dibujar con el renderbuffer
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer *)self.layer];
    //se une el renderbuffer a uno de los puntos de acoplamiento del framebuffer
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderBuffer);
    
    //almacena en las variables backingWidth y backingHeight las dimensiones del renderbuffer, es decir, las dimensiones de la superficie en la que se va a dibujar
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    //En caso de querer utilizar el depthbuffer no tenemos más que poner a 1 USE_DEPTH_BUFFER. Sin embargo, con estructuras 2D no se necesita utilizar este buffer. OpenGL utiliza el "algoritmo del pintor" para dibujar los objetos. Aquel objeto que primero se mande será el primero en dibujarse, de manera que el objeto que llegue tras el se dibujará encima, y así sucesivamente. Esto podría causar problemas con estructuras 3D. 
    
    if (USE_DEPTH_BUFFER) {
        //Se hace exactamente lo mismo que con los buffers anteriores
        glGenRenderbuffersOES(1, &depthRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER_OES, depthRenderBuffer);
        //GL_DEPTH_COMPONENT16_OES representa la dirección de memoria donde está el valor de depth. Como no se va a utilizar transición de páginas, lo mejor es que este a cero.
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderBuffer);

    }
    
    //glCheckFramebufferStatusOES devuelve información sobre aquellos atributos del framebuffer que son incorrectos o se han perdido en caso de que el framebuffer no este "completo".
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
    
}

- (void)destroyFrameBuffer {
    glDeleteFramebuffersOES(1, &viewFrameBuffer);
    viewFrameBuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderBuffer);
    viewRenderBuffer = 0;
    
    if (depthRenderBuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderBuffer);
        depthRenderBuffer = 0;
    }
}


//FovY: field of view en el eje Y
//PARÁMETROS
//fovY: ángulo de visión (en grados) en la dirección del eje Y
//aspect: ratio de x sobre y
//zNear: distancia desde el usuario hasta el plano más cercano (positivo)
//zFar: distancia desde el ususario hasta el plano más lejano (positivo)

- (void)perspectiveFovY:(GLfloat)fovY aspect:(GLfloat)aspect zNear:(GLfloat)zNear zFar:(GLfloat)zFar  {
    GLfloat halfHeight, halfWidth;
    //Con la siguiente función se consigue la mitad de la altura del plano más cercano (según el parámetro zNear)
    halfHeight = tan( (fovY / 2) / 180 * PI ) * zNear;
    //Con la siguiente función se obtiene la mitad de la anchura del plano más cercano porque se conoce el ratio de x sobre y, es decir, se sabe cuántas x hay por cada y
    halfWidth = halfHeight * aspect;
    //Finalmente, se llama a glFrustrum para construir el volumen en el que se va a dibujar. En los campos de la función se especifica a qué distancia se encuantra cada uno de los cuatro planos respecto del centro (0,0). Además, es necesario saber a qué distancia se encuentra el usuario del plano más cercano, así como el más lejano.
    glFrustumf(-halfWidth, halfWidth, -halfHeight, halfHeight, zNear, zFar);
}

- (GLint)getBackingWidth {
    return backingWidth;
}

- (GLint)getBackingHeight {
    return backingHeight;
}

- (void)dealloc {
    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [context release];
    [super dealloc];
}

@end
