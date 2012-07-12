//
//  MGLifesController.h
//  MyGame
//
//  Created by Marina Osés Merino on 26/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGLifesPresenter.h"

@class MGSceneController;

@interface MGLifesController : NSObject {
    MGLifesPresenter *_lifesPresenter;
    NSMutableArray *_lifesMarker;
    NSMutableArray *_sceneObjects;
    NSInteger nextLifeWithoutUsing;
    NSInteger numberOfLifes;
    MGSceneController *_sceneController;
}

@property (nonatomic, retain) MGLifesPresenter *lifesPresenter;
@property (nonatomic, retain) NSMutableArray *lifesMarker;
@property (nonatomic, retain) NSMutableArray *sceneObjects;
@property (nonatomic, assign) NSInteger nextLifeWithoutUsing;
@property (nonatomic, retain) MGSceneController *sceneController;


- (id)initWithSceneController:(MGSceneController *)scene_controller SceneObjects:(NSMutableArray *)scene_objects FirstTranslation:(MGPoint)first_translation ScaleOfPresentation:(MGPoint)scale_of_presentation NumberOfLifes:(NSInteger)number_of_lifes;

- (void)createAndAddLifesMarker;
- (void)aLifeHasBeenSpent;
- (void)aLifeHasBeenRecovered;
@end
