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
#define RANDOM_INT(_MIN_, _MAX_) ((arc4random() % (_MAX_ - _MIN_ + 1)) + _MIN_)
#define RANDOM_FLOAT(smallNumber, bigNumber) ((((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * (bigNumber - smallNumber)) + smallNumber)

//**********************************************************************************************

//--BIRD SIZES
#define MIN_BIRD_SCALE 35
#define MAX_BIRD_SCALE 55

//--BIRD SPEED
//Es la proporción entre los objetos más rápidos y más lentos. Una vez se haya calculado aleatoriamente la velocidad entre estos dos números tendremos que adecuar el resultado a píxeles de pantalla.
#define MIN_BIRD_SPEED 40    
#define MAX_BIRD_SPEED 100

//--NUMBER OF BIRDS TO APPEAR
#define MIN_BIRDS_TO_APPEAR 1
#define MAX_BIRDS_TO_APPEAR 4

//--NUMBER OF SECONDS BETWEEN BIRDS APPEARANCES
#define MINSEC_TO_BIRD_APPEARANCE  3 
#define MAXSEC_TO_BIRD_APPEARANCE 8 

//**********************************************************************************************
//Por el momento las escalas y velocidades de los patos serán siempre las mismas
//--DUCK SIZES
#define MIN_DUCK_SCALE 40
#define MAX_DUCK_SCALE 40

//--BIRD SPEED
#define MIN_DUCK_SPEED 50    
#define MAX_DUCK_SPEED 50

//--NUMBER OF DUCKS TO APPEAR
#define MIN_DUCKS_TO_APPEAR 1
#define MAX_DUCKS_TO_APPEAR 2

//--NUMBER OF SECONDS BETWEEN DUCKS APPEARANCES
#define MINSEC_TO_DUCK_APPEARANCE 7
#define MAXSEC_TO_DUCK_APPEARANCE 8


//**********************************************************************************************
//-- MAX ROTATION FOR LEAVES
#define MAX_LEAF_ROTATION 359

//--LEAF SIZES
#define MIN_LEAF_SCALE 20
#define MAX_LEAF_SCALE 40


//--NUMBER OF LEAVES TO APPEAR
#define MIN_LEAVES_TO_APPEAR 1
#define MAX_LEAVES_TO_APPEAR 2


//-- LEAF'S LIFE TIME
#define MINSEC_TO_LEAF_DISAPPEARANCE 10
#define MAXSEC_TO_LEAF_DISAPPEARANCE 15


//--NUMBER OF SECONDS BETWEEN LEAVES APPEARANCES
#define MINSEC_TO_LEAF_APPEARANCE 20
#define MAXSEC_TO_LEAF_APPEARANCE 25


//**********************************************************************************************
//-- MAX ROTATION FOR BEE
#define MAX_BEE_ROTATION 45

//--BEE SIZES
#define MIN_BEE_SCALE 20
#define MAX_BEE_SCALE 40


//--NUMBER OF BEES TO APPEAR
#define MIN_BEES_TO_APPEAR 1
#define MAX_BEES_TO_APPEAR 1


//-- BEE'S LIFE TIME
#define MINSEC_TO_BEE_DISAPPEARANCE 7
#define MAXSEC_TO_BEE_DISAPPEARANCE 15


//--NUMBER OF SECONDS BETWEEN BEES APPEARANCES
#define MINSEC_TO_BEE_APPEARANCE 60
#define MAXSEC_TO_BEE_APPEARANCE 90


//**********************************************************************************************
#define DEBUG_DRAW_COLLIDERS 1


#endif
