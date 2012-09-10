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
        pauseButtonToAssign.scale = MGPointMake(40.0,40.0, 1.0);
        pauseButtonToAssign.translation = MGPointMake(219.0, 138.0, 0.0);
        pauseButtonToAssign.target = self;
        pauseButtonToAssign.buttonGoodAction = @selector(goodTouchOfPauseButtonIsDone);
        pauseButtonToAssign.buttonBadAction = @selector(badTouchOfPauseButtonIsDone);
        self.pauseButton = pauseButtonToAssign;
        [pauseButtonToAssign release];
        
        _numbersDelegate = [[MGNumbersDelegate alloc] initWithSceneController:scene_controller SceneObjects:self.sceneObjects SceneObjectDestroyer:self.sceneObjectDestroyerForState];
        
        
        
        
        _lifesController = [[MGLifesController alloc] initWithSceneController:self.sceneControllerForState SceneObjects:self.sceneObjects FirstTranslation:MGPointMake(LIFES_FIRST_TRANSLATION_X, LIFES_FIRST_TRANSLATION_Y, 0.0) ScaleOfPresentation:MGPointMake(LIFES_SCALE, LIFES_SCALE, 1.0) NumberOfLifes:NUMBER_OF_LIFES];
        
        _scoreTransmitter = [[MGScoreTransmitter alloc] initWithScoreBoard:self.scoreBoard NumbersDelegate:self.numbersDelegate LifesController:self.lifesController];
        
        _boundaryController = [[MGBoundaryController alloc] initWithSceneController:self.sceneControllerForState ScoreTransmitter:self.scoreTransmitter SceneObjectDestroyer:self.sceneObjectDestroyerForState LifesController:self.lifesController SceneObjects:self.sceneObjects];


        self.takenLeavesButton.target = self;
        self.takenLeavesButton.buttonGoodAction = @selector(goodTouchOfTakenLeavesButton);
        self.takenLeavesButton.buttonBadAction = @selector(badTouchOfTakenLeavesButton);
        MGTimeController *timeControllerToAssign = self.sceneControllerForState.timeController;
        timedMultipleObjectGeneratorForNests = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:NESTS WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyerForState ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
        timedMultipleObjectGeneratorForArrows = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:ARROWS WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyerForState ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
        timedMultipleObjectGeneratorForLeaves = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:LEAVES WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyerForState ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
        timedMultipleObjectGeneratorForBees = [[MGTimedMultipleObjectGenerator alloc] initWithMGGenerator:[MGTimedMultipleObjectGenerator createSpecificMGGenerator:BEES WithSceneController:scene_controller BoundaryController:self.boundaryController SceneObjectDestroyer:self.sceneObjectDestroyerForState ScoreTransmitter:self.scoreTransmitter SceneObjects:self.sceneObjects] TimeController:timeControllerToAssign];
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
    [timedMultipleObjectGeneratorForNests loadNewObjectsWaveToAdd];
    [timedMultipleObjectGeneratorForArrows loadNewObjectsWaveToAdd];
    
    //[timedMultipleObjectGeneratorForLeaves loadNewObjectsWaveToAdd];
    [timedMultipleObjectGeneratorForNests setNextTimeToAppear];
    [timedMultipleObjectGeneratorForArrows setNextTimeToAppear];
    [timedMultipleObjectGeneratorForLeaves setNextTimeToAppear];
    [timedMultipleObjectGeneratorForBees setNextTimeToAppear];
    [super loadState];
}


- (void)startState {
    self.pauseButton.target = self;

    [super startState];
}



- (void)updateState {
    if ([[timedMultipleObjectGeneratorForNests objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForNests objectsToAdd]];
        [timedMultipleObjectGeneratorForNests clearObjectsToAdd];
    }
    if ([[timedMultipleObjectGeneratorForArrows objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForArrows objectsToAdd]];
        [timedMultipleObjectGeneratorForArrows clearObjectsToAdd];
    }
    
    if ([[timedMultipleObjectGeneratorForLeaves objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForLeaves objectsToAdd]];
        [timedMultipleObjectGeneratorForLeaves clearObjectsToAdd];
    }
    
    if ([[timedMultipleObjectGeneratorForBees objectsToAdd] count] > 0) {
        [self.sceneObjects addObjectsFromArray:[timedMultipleObjectGeneratorForBees objectsToAdd]];
        [timedMultipleObjectGeneratorForBees clearObjectsToAdd];
    }
    [self.sceneObjectDestroyerForState destroyFrom:self.sceneObjects];

    //Con la siguiente instrucción se consigue que los patos hagan su update antes que los nidos
    for (MGSceneObject *obj in [self.sceneObjects reverseObjectEnumerator]) {
        [obj update];
    }
    
    [self.collisionController handleCollisions];
    //[super updateState];

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
    [self.sceneControllerForState.stateManager goToPauseState];    
}

- (void)badTouchOfPauseButtonIsDone {
    //Podría ampliarse la funcionalidad
}




- (void)dealloc {
    [timedMultipleObjectGeneratorForNests release];
    [timedMultipleObjectGeneratorForArrows release];
    [timedMultipleObjectGeneratorForLeaves release];
    [timedMultipleObjectGeneratorForBees release];
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
