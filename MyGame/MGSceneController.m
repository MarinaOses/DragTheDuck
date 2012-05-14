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

@end



@implementation MGSceneController

@synthesize inputViewController = _inputViewController;
@synthesize openGLView = _openGLView;
@synthesize stateManager = _stateManager;




//se podría omitir el método init
- (id)init {
    self = [super init];
    if (self) {
        lastFrameTime = 0.0;
        cyclesLeftOver = 0.0;
    }
    return self;
}

- (void)buttonGoodActionLog {
    NSLog(@"GOOD");
}

- (void)buttonBadActionLog {
    NSLog(@"BAD");
}



#pragma mark - Scene Preload


//Se cargan todos los objetos de la escena
- (void)loadScene {
    MGPlayState *playState = (MGPlayState *)self.stateManager.activeState;
    [playState loadPlayState];
    
}

- (void)startScene {
    //Partiendo de los fps establecidos para la animación se obtiene el número de por fotograma, es decir, se calcula la inversa de los fps.
    animationInterval = 1.0/ANIMATION_FRAME_RATE;
    [self startAnimation];
    MGPlayState *playState = (MGPlayState *)self.stateManager.activeState;
    [playState startPlayState];
}


#pragma mark - Game Loop

- (void)updateScene {
    //llamar a 'update' de todos los objetos de la escena
    MGPlayState *playState = (MGPlayState *)self.stateManager.activeState;
    [playState updatePlayState];
    //limpiar los eventos que ya se han updateado
    [self.inputViewController clearEvents];
}

- (void)renderScene {
    //poner activo el frame para dibujar
    [self.openGLView beginDraw];
    //llamar al 'render' de todos los objetos para que se dibujen en pantalla
    MGPlayState *playState = (MGPlayState *)self.stateManager.activeState;
    [playState renderPlayState];
    //finalizar el frame
    [self.openGLView finishDraw];
}

- (void)gameLoop {
    int i = 0;
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
        i++;
        //NSLog(@"i ****************= %d",i);
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
    MGPlayState *playState = (MGPlayState *)self.stateManager.activeState;
    [playState stopPlayState];
    animationTimer = nil;
}



#pragma mark - dealloc

- (void)dealloc {
    [self stopAnimation];
    [_inputViewController release];
    [_openGLView release];
    [_stateManager release];
    [super dealloc];
}

@end
