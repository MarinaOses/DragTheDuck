//
//  MGPlayState.m
//  MyGame
//
//  Created by Marina Osés Merino on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGPlayState.h"


#import "MGSceneController.h"

@implementation MGPlayState
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize collisionController = _collisionController;
@synthesize scoreBoard = _scoreBoard;
@synthesize takenLeavesButton = _takenLeavesButton;
@synthesize pauseButton = _pauseButton;
@synthesize scoreTransmitter = _scoreTransmitter;
@synthesize numbersDelegate = _numbersDelegate;
@synthesize boundaryController = _boundaryController;
@synthesize lifesController = _lifesController;

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super initWithSceneController:scene_controller];
    if (self) {
        _sceneObjectDestroyer = [[MGSceneObjectDestroyer alloc] init];
        _collisionController = [[MGCollisionController alloc] initWithSceneObjects:self.sceneObjects];
        _scoreBoard = [[MGScoreBoard alloc] init];
//        _takenLeavesButton = [[MGTakenLeavesButton alloc] initWithSceneController:scene_controller 
//                            Translation:MGPointMake(-210.0, -130.0, 0.0) 
//                            Rotation:MGPointZero() 
//                            Scale:MGPointMake(40.0, 40.0, 1.0) 
//                            scoreBoard:self.scoreBoard];
        _takenLeavesButton = [[MGTakenLeavesButton alloc] initWithSceneController:scene_controller 
                            Translation:MGPointMake(0.0, -130.0, 0.0) 
                            Rotation:MGPointZero() 
                            Scale:MGPointMake(60.0, 60.0, 1.0) 
                            scoreBoard:self.scoreBoard];
        

        
        //************************************
        //Creación de botón
        //************************************
        
        MGTexturedButton *pauseButtonToAssign = [[MGTexturedButton alloc] initWithSceneController:self.sceneControllerForState UpKey:@"mg_button_pause.png" downKey:@"mg_button_pause_pressed.png"];
        pauseButtonToAssign.scale = MGPointMake(35.0,35.0, 1.0);
        pauseButtonToAssign.translation = MGPointMake(220.0, 140.0, 0.0);
        pauseButtonToAssign.target = self;
        pauseButtonToAssign.buttonGoodAction = @selector(goodTouchOfPauseButtonIsDone);
        pauseButtonToAssign.buttonBadAction = @selector(badTouchOfPauseButtonIsDone);
        self.pauseButton = pauseButtonToAssign;
        [pauseButtonToAssign release];
        
        _numbersDelegate = [[MGNumbersDelegate alloc] initWithSceneController:scene_controller SceneObjects:self.sceneObjects SceneObjectDestroyer:self.sceneObjectDestroyer];
        
        
        
        
        _lifesController = [[MGLifesController alloc] initWithSceneController:self.sceneControllerForState SceneObjects:self.sceneObjects FirstTranslation:MGPointMake(LIFES_FIRST_TRANSLATION_X, LIFES_FIRST_TRANSLATION_Y, 0.0) ScaleOfPresentation:MGPointMake(LIFES_SCALE, LIFES_SCALE, 1.0) NumberOfLifes:NUMBER_OF_LIFES];
        
        _scoreTransmitter = [[MGScoreTransmitter alloc] initWithScoreBoard:self.scoreBoard NumbersDelegate:self.numbersDelegate LifesController:self.lifesController];
        
        _boundaryController = [[MGBoundaryController alloc] initWithSceneController:self.sceneControllerForState ScoreTransmitter:self.scoreTransmitter SceneObjectDestroyer:self.sceneObjectDestroyer LifesController:self.lifesController SceneObjects:self.sceneObjects];


        self.takenLeavesButton.target = self;
        self.takenLeavesButton.buttonGoodAction = @selector(goodTouchOfTakenLeavesButton);
        self.takenLeavesButton.buttonBadAction = @selector(badTouchOfTakenLeavesButton);
        MGTimeController *timeControllerToAssign = self.sceneControllerForState.timeController;
        timedMultipleObjectGeneratorForDucks = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:DUCKS WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
        timedMultipleObjectGeneratorForBirds = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:BIRDS WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
        timedMultipleObjectGeneratorForLeaves = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:LEAVES WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
        timedMultipleObjectGeneratorForBees = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:BEES WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyer ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
    }
    return self;
}

- (void)loadState {
    [self.sceneObjects removeAllObjects];
    //************************************
    //Creación de fondo
    //************************************
    
    MGSceneObject *background = [[MGSceneObject alloc] initWithSceneController:self.sceneControllerForState];
    background.scale = MGPointMake(480.0, 320.0, 1.0);
    background.translation = MGPointMake(0.0, 0.0, 0.0);
    background.mesh = [[MGMaterialController sharedMaterialController] quadFromKey:@"mg_fondo_completo.png"];
    [self.sceneObjects addObject:background];
    [background release];
    
    
    [self.sceneObjects addObject:self.takenLeavesButton];
    [self.sceneObjects addObject:self.takenLeavesButton.takenLeavesButtonShowerLayer];
    [self.sceneObjects addObject:self.pauseButton];
    [self.numbersDelegate initializeAllMembersOfStaff];
    [self.lifesController createAndAddLifesMarker];
    [self.boundaryController createEggBreaker];
    [timedMultipleObjectGeneratorForDucks loadNewObjectsWaveToAdd];
    [timedMultipleObjectGeneratorForBirds loadNewObjectsWaveToAdd];
    
    //[timedMultipleObjectGeneratorForLeaves loadNewObjectsWaveToAdd];
    [timedMultipleObjectGeneratorForDucks setNextTimeToAppear];
    [timedMultipleObjectGeneratorForBirds setNextTimeToAppear];
    [timedMultipleObjectGeneratorForLeaves setNextTimeToAppear];
    [timedMultipleObjectGeneratorForBees setNextTimeToAppear];
    [super loadState];
}


- (void)startState {
    self.pauseButton.target = self;

    [super startState];
}



- (void)updateState {
    if ([[timedMultipleObjectGeneratorForDucks objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForDucks objectsToAdd]];
        [timedMultipleObjectGeneratorForDucks clearObjectsToAdd];
    }
    if ([[timedMultipleObjectGeneratorForBirds objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForBirds objectsToAdd]];
        [timedMultipleObjectGeneratorForBirds clearObjectsToAdd];
    }
    
    if ([[timedMultipleObjectGeneratorForLeaves objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForLeaves objectsToAdd]];
        [timedMultipleObjectGeneratorForLeaves clearObjectsToAdd];
    }
    
    if ([[timedMultipleObjectGeneratorForBees objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForBees objectsToAdd]];
        [timedMultipleObjectGeneratorForBees clearObjectsToAdd];
    }
    [self.sceneObjectDestroyer destroyFrom:self.sceneObjects];
    [self.sceneObjects makeObjectsPerformSelector:@selector(update)];
    [self.collisionController handleCollisions];
    [super updateState];

}


- (void)renderState {
    [super renderState];
}

- (void)stopState {
    [super stopState];
    if (self.lifesController.nextLifeWithoutUsing < 0) {
        [self.sceneControllerForState.stateManager goToGameOverStateWith:self.scoreBoard];
    }

}

- (void)goodTouchOfTakenLeavesButton {
    MGMultipleArmorGenerator *multipleArmorGenerator = [[MGMultipleArmorGenerator alloc] initWithSceneController:self.sceneControllerForState BoundaryController:self.boundaryController SceneObjects:self.sceneObjects];
    [self.sceneObjects addObjectsFromArray:[multipleArmorGenerator createWave]];
    [multipleArmorGenerator release];
}

- (void)badTouchOfTakenLeavesButton {
    
}

- (void)goodTouchOfPauseButtonIsDone {
    [self.sceneControllerForState.stateManager stopActiveState];
    [self.sceneControllerForState.stateManager goToPauseStateWithSceneObjects:self.sceneObjects PauseButton:self.pauseButton];    
}

- (void)badTouchOfPauseButtonIsDone {
    //Podría ampliarse la funcionalidad
}




- (void)dealloc {
    [timedMultipleObjectGeneratorForDucks release];
    [timedMultipleObjectGeneratorForBirds release];
    [timedMultipleObjectGeneratorForLeaves release];
    [timedMultipleObjectGeneratorForBees release];
    [_sceneObjectDestroyer release];
    [_collisionController release];
    [_scoreBoard release];
    [_takenLeavesButton release];
    [_pauseButton release];
    [_scoreTransmitter release];
    [_numbersDelegate release];
    [_boundaryController release];
    [_lifesController release];
    [super dealloc];
}


@end
