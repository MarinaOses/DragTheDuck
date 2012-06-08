//
//  MGMultipleFigureDecorator.h
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGFigureDecorator.h"

@interface MGMultipleFigureDecorator : NSObject {
    MGFigureDecorator *_figureDecorator;
}

@property (nonatomic, retain) MGFigureDecorator *figureDecorator;

- (id)initWithSceneController:(MGSceneController *)scene_controller;
- (NSMutableArray *)createFiguresWithValuesInArray:(NSMutableArray *)values_array;
@end
