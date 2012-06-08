//
//  MGMultipleFigureDecorator.m
//  MyGame
//
//  Created by Marina Osés Merino on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGMultipleFigureDecorator.h"

@implementation MGMultipleFigureDecorator
@synthesize figureDecorator = _figureDecorator;

- (id)initWithSceneController:(MGSceneController *)scene_controller {
    self = [super init];
    if (self) {
        _figureDecorator = [[MGFigureDecorator alloc] initWithSceneController:scene_controller];
    }
    return self;
}

- (NSMutableArray *)createFiguresWithValuesInArray:(NSMutableArray *)components_array {
    if (components_array != nil) {
        NSMutableArray *arrayWithFigures = [[NSMutableArray alloc] initWithCapacity:[components_array count]];
        for (NSString *val in components_array) {
            MGSceneObject *newFigure = [self.figureDecorator createFigureWithValue:val];
            [arrayWithFigures addObject:newFigure];
        }
        return [arrayWithFigures autorelease];
    }
    NSLog(@"Aviso: El array de valores para crear el número es incorrecto");
    return nil;
    
}



- (void)dealloc {
    [_figureDecorator release];
    [super dealloc];
}
@end
