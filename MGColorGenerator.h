//
//  RGBAColorGenerator.h
//  MyGame
//
//  Created by Marina Osés Merino on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGColorGenerator : NSObject

+ (CGFloat *)createColorWithSize:(NSInteger)color_size ForNumberOfVertexes:(NSInteger)vertex_count WithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;

@end
