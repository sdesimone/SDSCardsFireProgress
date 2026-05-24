//
//  CAAnimation+Completion.h
//  CAAnimationCompletion
//
//  Created by Sergio De Simone on 7/7/11.
//  Copyright 2013 Freescapes Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
@interface CALayer (AnimationCompletion)

- (void)addAnimation:(CAAnimation*)animation
              forKey:(NSString*)key
          completion:(void (^)(BOOL))completion;

@end

