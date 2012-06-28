//
//  MGNumbersDelegate.m
//  MyGame
//
//  Created by Marina Osés Merino on 08/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGNumbersDelegate.h"

@implementation MGNumbersDelegate
@synthesize savedDucksPresenter = _savedDucksPresenter;
@synthesize killedBirdsPresenter = _killedBirdsPresenter;
@synthesize savedDucksIconPresenter = _savedDucksIconPresenter;
@synthesize killedBirdsIconPresenter = _killedBirdsIconPresenter;
@synthesize sceneObjects = _sceneObjects;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;
@synthesize killedBirdsIcon = _killedBirdsIcon;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super init];
    if (self) {
        _savedDucksPresenter = [[MGNumberPresenter alloc] initWithSceneController:scene_controller StartAtPoint:MGPointMake(SAVED_DUCKS_SCORE_START_X, SAVED_DUCKS_SCORE_START_Y, 0.0) ScaleOfPresentation:MGPointMake(NUMBERS_SCALE, NUMBERS_SCALE, 1.0)];
        _killedBirdsPresenter = [[MGNumberPresenter alloc] initWithSceneController:scene_controller StartAtPoint:MGPointMake(KILLED_BIRDS_SCORE_START_X, KILLED_BIRDS_SCORE_START_Y, 0.0) ScaleOfPresentation:MGPointMake(NUMBERS_SCALE, NUMBERS_SCALE, 1.0)];
        _savedDucksIconPresenter = [[MGIconPresenter alloc] initWithSceneController:scene_controller StartPointOfTheNumberThatComesAfter:MGPointMake(SAVED_DUCKS_SCORE_START_X, SAVED_DUCKS_SCORE_START_Y, 0.0) ScaleOfPresentation:MGPointMake(ICONS_SCALE, ICONS_SCALE, 1.0)];
        _killedBirdsIconPresenter = [[MGIconPresenter alloc] initWithSceneController:scene_controller StartPointOfTheNumberThatComesAfter:MGPointMake(KILLED_BIRDS_SCORE_START_X, KILLED_BIRDS_SCORE_START_Y, 0.0) ScaleOfPresentation:MGPointMake(ICONS_SCALE, ICONS_SCALE, 1.0)];
        self.sceneObjects = scene_objects;
        self.sceneObjectDestroyer = scene_object_destroyer;
    }
    return self;
}


- (void)initializeAllMembersOfStaff {
    MGSceneObject *iconToAdd = [self.savedDucksIconPresenter createIconObject];
    [self.sceneObjects addObject:iconToAdd];
    NSMutableArray *startNumberToAdd = [self.savedDucksPresenter createNumberObjectWithValue:0];
    [self.sceneObjects addObjectsFromArray:startNumberToAdd];
}


- (void)initializeKilledBirdsMarker {
    MGSceneObject *iconToAdd = [self.killedBirdsIconPresenter createIconObject];
    self.killedBirdsIcon = iconToAdd;
    [self.sceneObjects addObject:iconToAdd];
    NSMutableArray *startNumberToAdd = [self.killedBirdsPresenter createNumberObjectWithValue:0];
    [self.sceneObjects addObjectsFromArray:startNumberToAdd];
}


- (void)presentAndAddNewScore:(NSInteger)score ToMarker:(NSInteger)position_of_number {
    NSMutableArray *arrayWithPresentation;
    if (position_of_number == 1) {
        arrayWithPresentation = [self.savedDucksPresenter createNumberObjectWithValue:score];
    }
    else {
        arrayWithPresentation = [self.killedBirdsPresenter createNumberObjectWithValue:score];
    }
    [self.sceneObjects addObjectsFromArray:arrayWithPresentation];
}


- (void)removeThePreviousScore:(NSInteger)position_of_number {
    for (MGSceneObject *obj in self.sceneObjects) {
        if (obj.positionOfNumber == position_of_number) {
            [self.sceneObjectDestroyer markToRemoveSceneObject:obj];
        }
    }
}

- (void)removeTheIconOfKilledBirdsMarker {
    [self.sceneObjectDestroyer markToRemoveSceneObject:self.killedBirdsIcon];
    [_killedBirdsIcon release];
    _killedBirdsIcon = nil;
}


- (void)removeKilledBirdsMarker {
    [self removeThePreviousScore:2];
    [self removeTheIconOfKilledBirdsMarker];
}

- (void)updateTheMarker:(NSInteger)position_of_number With:(NSInteger)score {
    [self removeThePreviousScore:position_of_number];
    [self presentAndAddNewScore:score ToMarker:position_of_number];

}


- (void)dealloc {
    [_savedDucksPresenter release];
    [_killedBirdsPresenter release];
    [_savedDucksIconPresenter release];
    [_killedBirdsIconPresenter release];
    [_sceneObjects release];
    [_sceneObjectDestroyer release];
    if (_killedBirdsIcon != nil) {
        [_killedBirdsIcon release];
    }
    [super dealloc];
}

@end
