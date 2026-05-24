//
//  CAAnimation+Completion.h
//  CAAnimationCompletion
//
//  Created by Sergio De Simone on 7/7/11.
//  Copyright 2013 Freescapes Labs. All rights reserved.
//

#import "CALayer+AnimationCompletion.h"


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
@interface CAAnimationDelegate : NSObject

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
@implementation CAAnimationDelegate

////////////////////////////////////////////////////////////////////////
- (id)init {
    
    if ((self = [super init])) {
    }
    return self;
}

////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
- (void)animationDidStop:(CAAnimation*)anim finished:(BOOL)flag {
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    void (^completion)(BOOL) = [anim valueForKey:@"completionBlock"];
    if (completion) {
        completion(flag);
        Block_release(completion);
    }
    
    [CATransaction commit];
    
    if (!anim.removedOnCompletion) {
        CALayer* layer = (id)[anim valueForKey:@"animationLayer"];
        NSString* animationKey = (id)[anim valueForKey:@"animationKey"];
        [layer removeAnimationForKey:animationKey];
    }
}

@end

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
@implementation CALayer (AnimationCompletion)

////////////////////////////////////////////////////////////////////////
- (void)addAnimation:(CAAnimation*)animation
              forKey:(NSString*)key
          completion:(void (^)(BOOL))completion {

    if (completion)
        [animation setValue:Block_copy(completion) forKey:@"completionBlock"];
    
    NSString* keypath = @"";
    if ([animation isKindOfClass:[CAPropertyAnimation class]])
        keypath = [(CAPropertyAnimation*)animation keyPath];

    NSString* animationKey = [NSString stringWithFormat:@"%@.%@", key, keypath];
    [animation setValue:animationKey forKey:@"animationKey"];

    [animation setValue:self forKey:@"animationLayer"];

    animation.delegate = [[[CAAnimationDelegate alloc] init] autorelease];
    
    [self addAnimation:animation forKey:animationKey];
}

@end
