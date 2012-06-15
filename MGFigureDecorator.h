//
//  MGFigureDecorator.h
//  MyGame
//
//  Created by Marina Osés Merino on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGValidator.h"
#import "MGColorGenerator.h"
#import "MGSceneObject.h"

@interface MGFigureDecorator : NSObject {
    CGFloat *RGBAColors;
    
    MGSceneController *_sceneController;
}

@property (nonatomic, assign) CGFloat *RGBAColors;
@property (nonatomic, retain) MGSceneController *sceneController;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (MGSceneObject *)createFigureWithValue:(NSString *)string_value;
@end
