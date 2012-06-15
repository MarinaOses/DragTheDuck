//
//  MGNumbersDelegate.m
//  MyGame
//
//  Created by Marina Osés Merino on 08/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGNumbersDelegate.h"

@implementation MGNumbersDelegate
@synthesize numberPresenter = _numberPresenter;
@synthesize iconPresenter = _iconPresenter;
@synthesize sceneObjects = _sceneObjects;
@synthesize sceneObjectDestroyer = _sceneObjectDestroyer;

- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects SceneObjectDestroyer:(MGSceneObjectDestroyer *)scene_object_destroyer {
    self = [super init];
    if (self) {
        _numberPresenter = [[MGNumberPresenter alloc] initWithSceneController:scene_controller StartAtPoint:MGPointMake(SAVED_DUCKS_SCORE_START_X, SAVED_DUCKS_SCORE_START_Y, 0.0) ScaleOfPresentation:MGPointMake(NUMBERS_SCALE, NUMBERS_SCALE, 1.0)];
        _iconPresenter = [[MGIconPresenter alloc] initWithSceneController:scene_controller StartPointOfTheNumberThatComesAfter:MGPointMake(SAVED_DUCKS_SCORE_START_X, SAVED_DUCKS_SCORE_START_Y, 0.0) ScaleOfPresentation:MGPointMake(ICONS_SCALE, ICONS_SCALE, 1.0)];
        self.sceneObjects = scene_objects;
        self.sceneObjectDestroyer = scene_object_destroyer;
    }
    return self;
}


- (void)initializeAllMembersOfStaff {
    MGSceneObject *iconToAdd = [self.iconPresenter createIconObject];
    [self.sceneObjects addObject:iconToAdd];
    NSMutableArray *startNumberToAdd = [self.numberPresenter createNumberObjectWithValue:0];
    [self.sceneObjects addObjectsFromArray:startNumberToAdd];
}

- (void)presentAndAddNewScore:(NSInteger)score {
    NSMutableArray *arrayWithPresentation = [self.numberPresenter createNumberObjectWithValue:score];
    [self.sceneObjects addObjectsFromArray:arrayWithPresentation];
}

- (void)removeThePreviousScore {
    for (MGSceneObject *obj in self.sceneObjects) {
        if (obj.isANumber) {
            [self.sceneObjectDestroyer markToRemoveSceneObject:obj];
        }
    }
}

- (void)updateTheMarkerWith:(NSInteger)score {
    [self removeThePreviousScore];
    [self presentAndAddNewScore:score];
}


- (void)dealloc {
    [_numberPresenter release];
    [_iconPresenter release];
    [_sceneObjects release];
    [_sceneObjectDestroyer release];
    [super dealloc];
}

@end
