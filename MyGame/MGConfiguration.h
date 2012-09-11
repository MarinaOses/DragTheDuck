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
#define RANDOM_INT(_MIN_, _MAX_) ((arc4random() % ((_MAX_) - (_MIN_) + 1)) + (_MIN_))
#define RANDOM_FLOAT(_smallNumber_, _bigNumber_) (floorf(((float)arc4random() / 0xFFFFFFFFu) * ((_bigNumber_) - (_smallNumber_))) + (_smallNumber_))

//**********************************************************************************************


#define DUCK_COLOR 0
#define BIRD_COLOR 1

//**********************************************************************************************


//--BIRD SIZES
#define MIN_BIRD_SCALE 40
#define MAX_BIRD_SCALE 60

//--BIRD SPEED
//Es la proporción entre los objetos más rápidos y más lentos. Una vez se haya calculado aleatoriamente la velocidad entre estos dos números tendremos que adecuar el resultado a píxeles de pantalla.
#define MIN_BIRD_SPEED 80    
#define MAX_BIRD_SPEED 120


//**********************************************************************************************

//--ARROW SIZES
#define MIN_ARROW_SCALE 30
#define MAX_ARROW_SCALE 30

//--ARROW SPEED

#define MIN_ARROW_SPEED 40    
#define MAX_ARROW_SPEED 40
#define SEC_BEFORE_THE_BIRD_APPEARS 3

//--NUMBER OF ARROWS TO APPEAR
#define MIN_ARROWS_TO_APPEAR 1
#define MAX_ARROWS_TO_APPEAR 2

//--NUMBER OF SECONDS BETWEEN ARROWS APPEARANCES
#define MINSEC_TO_ARROW_APPEARANCE 3 
#define MAXSEC_TO_ARROW_APPEARANCE 8 


//--AUMENTO DE DIFICULTAD POR LA FRECUENCIA EN LA QUE APARECEN
#define ARROWS_TO_LEVEL_UP 30
#define MINSEC_TO_ARROW_APPEARANCE_DECREASE 1
#define MAXSEC_TO_ARROW_APPEARANCE_DECREASE 4



//**********************************************************************************************
//Por el momento las escalas y velocidades de los patos serán siempre las mismas
//--DUCK SIZES
#define MIN_DUCK_SCALE 50
#define MAX_DUCK_SCALE 50

//--DUCK SPEED
#define MIN_DUCK_SPEED 60   
#define MAX_DUCK_SPEED 60


//**********************************************************************************************
//Por el momento las escalas y velocidades de los nidos serán siempre las mismas
//--NEST SIZES
#define MIN_NEST_SCALE 50
#define MAX_NEST_SCALE 50

//--NEST SPEED
#define MIN_NEST_SPEED 40   
#define MAX_NEST_SPEED 40
#define NEST_ROUTE 30
#define SEC_BEFORE_THE_DUCK_APPEARS 3

//--NUMBER OF NESTS TO APPEAR
#define MIN_NESTS_TO_APPEAR 1
#define MAX_NESTS_TO_APPEAR 1



//--NUMBER OF SECONDS BETWEEN NEST APPEARANCES
#define MINSEC_TO_NEST_APPEARANCE 2
#define MAXSEC_TO_NEST_APPEARANCE 4


//--AUMENTO DE DIFICULTAD POR EL NÚMERO DE NIDOS QUE APARECEN
#define NESTS_TO_LEVEL_UP 20
#define MIN_NESTS_TO_APPEAR_INCREASE 0
#define MAX_NESTS_TO_APPEAR_INCREASE 1


//**********************************************************************************************
//---TRANSFORMER SIZES
#define MIN_TRANSFORMER_SCALE 70
#define MAX_TRANSFORMER_SCALE 70

//--TRANFORMER SPEED
#define MIN_TRANSFORMER_SPEED 100    
#define MAX_TRANSFORMER_SPEED 100


//**********************************************************************************************
//-- MAX ROTATION FOR LEAVES
#define MAX_LEAF_ROTATION 359

//--LEAF SIZES
#define MIN_LEAF_SCALE 40
#define MAX_LEAF_SCALE 60


//--NUMBER OF LEAVES TO APPEAR
#define MIN_LEAVES_TO_APPEAR 1
#define MAX_LEAVES_TO_APPEAR 1


//-- LEAF'S LIFE TIME
#define MINSEC_TO_LEAF_DISAPPEARANCE 10
#define MAXSEC_TO_LEAF_DISAPPEARANCE 15


//--NUMBER OF SECONDS BETWEEN LEAVES APPEARANCES
#define MINSEC_TO_LEAF_APPEARANCE 10
#define MAXSEC_TO_LEAF_APPEARANCE 25


//**********************************************************************************************
//-- MAX ROTATION FOR BEE
#define MAX_BEE_ROTATION 45

//--BEE SIZES
#define MIN_BEE_SCALE 40
#define MAX_BEE_SCALE 70


//--NUMBER OF BEES TO APPEAR
#define MIN_BEES_TO_APPEAR 1
#define MAX_BEES_TO_APPEAR 1


//-- BEE'S LIFE TIME
#define MINSEC_TO_BEE_DISAPPEARANCE 7
#define MAXSEC_TO_BEE_DISAPPEARANCE 15


//--NUMBER OF SECONDS BETWEEN BEES APPEARANCES
#define MINSEC_TO_BEE_APPEARANCE 40
#define MAXSEC_TO_BEE_APPEARANCE 70


//**********************************************************************************************
#define MINSEC_TO_TRANSFORMER_DISAPPEARANCE 5
#define MAXSEC_TO_TRANSFORMER_DISAPPEARANCE 15

//**********************************************************************************************
#define DEBUG_DRAW_COLLIDERS 0


//**********************************************************************************************
//Número de píxeles que se agregan a cada lado del pato para formar el área en que el pato puede cogerse
#define ADD_TO_SCREENRECT_OF_DRAGGEABLE 10
#define ADD_TO_SCREENRECT_OF_BUTTONS 4


//**********************************************************************************************
#define NUMBERS_SAVED_DUCKS_SCALE 45 
#define ICON_SAVED_DUCKS_SCALE 60
#define SPACE_BETWEEN_ICON_NUMBERS 8
#define SPACE_BETWEEN_NUMBERS_NUMBERS 15
//start_x representa el punto en el eje x donde se sitúa el lado izquierdo del primer número
#define SAVED_DUCKS_SCORE_START_X -170
#define SAVED_DUCKS_SCORE_START_Y -130


//**********************************************************************************************
//start_x representa el punto en el eje x donde se sitúa el lado izquierdo del primer número
#define NUMBERS_KILLED_BIRDS_SCALE 30
#define ICON_KILLED_BIRDS_SCALE 30
#define KILLED_BIRDS_SCORE_START_X -5
#define KILLED_BIRDS_SCORE_START_Y 140


//**********************************************************************************************
#define BIRDS_TO_RECOVER_A_LIFE 5

//**********************************************************************************************
#define MAX_TAKEN_LEAVES 1

//**********************************************************************************************
#define EGG_INITIAL_JUMP_SPEED 2.0
#define EGG_ACCELERATION 0.1

//**********************************************************************************************
#define SPACE_BETWEEN_LIFE_LIFE 10
#define LIFES_FIRST_TRANSLATION_X 70
#define LIFES_FIRST_TRANSLATION_Y -130
#define LIFES_SCALE 30
#define NUMBER_OF_LIFES 5

//**********************************************************************************************
#define GRASS_HEIGHT 80

//**********************************************************************************************
#define UPDATES_FOR_A_TRAVEL 100

//**********************************************************************************************
#define TAKEN_TIME_WITHOUT_MOVING 1

//**********************************************************************************************
#define TIME_TO_FLAP_ITS_WINGS 0.1


//**********************************************************************************************

#define MAX_FEATHERS_ROTATION 359
#define SEC_TO_FEATHERS_DISAPPEARANCE 1

//**********************************************************************************************
#define SECURITY_DISTANCE 10


//**********************************************************************************************
//SOUNDS

#define TRANSFORMER_FLYING @"transformer_flying"
#define LEAVES_BUTTON_ACTIVE @"leaves_button_active"
#define BIRD_KILLING @"bird_killing"
#define LEAVE_TAKING @"leave_taking"
#define BUTTON_CLICK @"button_click"
#define SAVED_DUCK @"saved_duck"
#define BACKGROUND @"background"
#define EGG_CRASH @"egg_crash"
#define EGG_FALLING @"egg_falling"
#define FRIED_EGG @"fried_egg"
#define DUCK @"duck"



#endif
