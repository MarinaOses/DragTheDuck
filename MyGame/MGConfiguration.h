//
//  MGConfiguration.h
//  MyGame
//
//  Created by Marina Osés Merino on 04/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MyGame_MGConfiguration_h
#define MyGame_MGConfiguration_h


//--- EAGLView
#define PI 3.1415926
#define USE_DEPTH_BUFFER 0



//--- Time
#define ANIMATION_FRAME_RATE 60.0 //fps real de la animación
#define MAXIMUM_FRAME_RATE 120.0 //fps máximo
#define MINIMUM_FRAME_RATE 15.0 //fps mínimo
#define SMALL_UPDATE_INTERVAL (1.0/MAXIMUM_FRAME_RATE) //segundos por frame mínimo
#define BIG_UPDATE_INTERVAL (1.0/MINIMUM_FRAME_RATE) //segundos por frame máximo


//--RANDOM FUNCTIONS
//No necesita SEED. Calcula un número aleatorio entre _MIN_ y _MAX_
#define RANDOM_INT(_MIN_, _MAX_) ((arc4random() % (_MAX_ - _MIN_)) + _MIN_)


//--BIRD SIZES
#define MIN_BIRD_SCALE 35
#define MAX_BIRD_SCALE 55

//--BIRD SPEED
#define MIN_SPEED_IN_PIXELS_PER_UPDATE 0.005 //Tener en cuenta: se hacen dos updates por cada render
#define MAX_SPEED_IN_PIXELS_PER_UPDATE 0.5


#endif
