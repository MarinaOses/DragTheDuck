//
//  MGMaterialController.h
//  MyGame
//
//  Created by Marina Osés Merino on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGTexturedQuad;

@interface MGMaterialController : NSObject {
    NSMutableDictionary *_materialLibrary;
    NSMutableDictionary *_quadLibrary;
}

@property (nonatomic, retain) NSMutableDictionary *materialLibrary;
@property (nonatomic, retain) NSMutableDictionary *quadLibrary;



+ (MGMaterialController *)sharedMaterialController;
- (void)bindMaterial:(NSString *)material_key;
- (MGTexturedQuad *)quadFromKey:(NSString *)key;
@end
