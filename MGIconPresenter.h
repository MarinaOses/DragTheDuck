//
//  MGIconPresenter.h
//  MyGame
//
//  Created by Marina Osés Merino on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGSceneObject.h"

@interface MGIconPresenter : NSObject {
    MGPoint scaleOfPresentation;
    MGPoint startPointOfTheNumberThatComesAfter;
    
    MGSceneController *_sceneController;
}

@property (nonatomic, retain) MGSceneController *sceneController;

- (id)initWithSceneController:(MGSceneController *)scene_controller StartPointOfTheNumberThatComesAfter:(MGPoint)start_point_of_the_number_that_comes_after ScaleOfPresentation:(MGPoint)scale_of_presentation;
- (MGSceneObject *)createIconObject;

@end
