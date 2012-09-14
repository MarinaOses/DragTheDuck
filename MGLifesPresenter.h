//
//  MGLifesPresenter.h
//  MyGame
//
//  Created by Marina Osés Merino on 26/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MGLife.h"

@class MGSceneController;

@interface MGLifesPresenter : NSObject {
    MGSceneController *_sceneController;
    MGPoint firstTranslation;
    MGPoint scaleOfPresentation;
}

@property (nonatomic, retain) MGSceneController *sceneController;


- (id)initWithSceneController:(MGSceneController *)scene_controller FirstTranslation:(MGPoint)first_translation ScaleOfPresentation:(MGPoint)scale_of_presentation;
- (NSMutableArray *)createLifesMarkerWith:(NSInteger)number_of_lifes;
@end
