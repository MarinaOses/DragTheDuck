//
//  MGSceneController.m
//  MyGame
//
//  Created by Marina Osés Merino on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGSceneController.h"

@interface MGSceneController ()

- (void)startAnimation;
- (void)invokeLoadResources;

@end



@implementation MGSceneController

@synthesize inputViewController = _inputViewController;
@synthesize openGLView = _openGLView;
@synthesize stateManager = _stateManager;
@synthesize timeController = _timeController;



//se podría omitir el método init
- (id)init {
    self = [super init];
    if (self) {
        lastFrameTime = 0.0;
        cyclesLeftOver = 0.0;
        [self invokeLoadResources];
    }
    return self;
}

- (void)buttonGoodActionLog {
    NSLog(@"GOOD");
}

- (void)buttonBadActionLog {
    NSLog(@"BAD");
}

- (void)invokeLoadResources {
    int number_of_classes;
    Class *list_of_classes = NULL;
    //Coger el número de clases para poder crear el buffer con un tamaño correcto
    number_of_classes = objc_getClassList(NULL, 0);
    if (number_of_classes > 0) {
        list_of_classes = malloc(number_of_classes * sizeof(Class));
        number_of_classes = objc_getClassList(list_of_classes, number_of_classes);
        NSLog(@"numberofclasses = %d", number_of_classes);
        for (int i = 0; i < number_of_classes; i++) {
            Class current_class = list_of_classes[i];
            if (class_getClassMethod(current_class, @selector(isSubclassOfClass:))) {
                if ([current_class isSubclassOfClass:[MGSceneObject class]]) {
                    //Se ha encontrado un MGSceneObject
                    if ([current_class respondsToSelector:@selector(loadResources)]) {
                        //Si se llama de la manera habitual ([current_class loadResources]) el compilador da un warning, ya que no reconoce de qué clase se trata
                        //Evitar el warning con objc_msgSend
                        objc_msgSend(current_class, @selector(loadResources));
                    }
                }
            }
        }
        free(list_of_classes);
    }
}



#pragma mark - Scene Preload


//Se cargan todos los objetos de la escena
- (void)loadScene {
    MGState *state = self.stateManager.activeState;
    [state loadState];
}

- (void)startScene {
    //Partiendo de los fps establecidos para la animación se obtiene el número de por fotograma, es decir, se calcula la inversa de los fps.
    animationInterval = 1.0/ANIMATION_FRAME_RATE;
    [self startAnimation];
    
    MGState *state = self.stateManager.activeState;
    [state startState];
}


#pragma mark - Game Loop

- (void)updateScene {
    //llamar a 'update' de todos los objetos de la escena
    MGState *state = self.stateManager.activeState;
    [state updateState];
    [[MGOpenALSoundController sharedSoundController] update];
    
    //limpiar los eventos que ya se han updateado
    [self.inputViewController clearEvents];
}

- (void)renderScene {
    //poner activo el frame para dibujar
    [self.openGLView beginDraw];
    //llamar al 'render' de todos los objetos para que se dibujen en pantalla
    MGState *state = self.stateManager.activeState;
    [state renderState];
    //finalizar el frame
    [self.openGLView finishDraw];
}

- (void)gameLoop {
    NSTimeInterval currentTime;
    NSTimeInterval updateIterations;
    
    //Devuelve el intervalo de segundos entre el primer instante del 1 de enero de 2001 GMT y el momento actual  
    currentTime = [NSDate timeIntervalSinceReferenceDate];
    //NSLog(@"current time ______________= %f", currentTime);
    
    updateIterations = (currentTime - lastFrameTime) + cyclesLeftOver;
    
    
    //Si el tiempo de animación que se va a updatear no puede ser superior a 1/15 segundos. Es decir, la animación debe funcionar como mínimo a 15 fps. Esto puede llevar a que el tiempo real no se corresponda con el tiempo de la animación. 
    if (updateIterations > BIG_UPDATE_INTERVAL) {
        updateIterations = BIG_UPDATE_INTERVAL;
    }
    
    //Se hace un update de la escena cada 1/120 segundos. En este caso, se puden hacer varios updates de la escena por cada renderizado de la misma. Cuanto mayor sea updateIterations mayor será el número de updates por render, luego la animación se verá con "cortes".
    while (updateIterations >= SMALL_UPDATE_INTERVAL) {
        updateIterations -= SMALL_UPDATE_INTERVAL;
        [self updateScene];
        [self.timeController anUpdateHappens];
        
    }
    //El tiempo de animación que no ha podido introducirse en el render anterior y es sumado al siguiente tiempo de renderizado. 
    cyclesLeftOver = updateIterations;
    
    lastFrameTime = currentTime;
    
    [self renderScene];
   
}


#pragma mark - Animation Timer

- (void)startAnimation {
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
}

- (void)stopAnimation {
    [animationTimer invalidate];
    animationTimer = nil;
    
}



#pragma mark - dealloc

- (void)dealloc {
    if (animationTimer != nil) {
        [self stopAnimation];
    }
    [_inputViewController release];
    [_openGLView release];
    [_stateManager release];
    [_timeController release];
    [super dealloc];
}

@end
