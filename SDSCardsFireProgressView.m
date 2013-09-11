//
//  SDSCardsFireProgressView
//
//  Created by sergio on 4/18/13.
//  Copyright (c) 2013 Sergio De Simone, Freescapes Labs. All rights reserved.
//

#import "SDSCardsFireProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import "CALayer+SDSLayerByName.h"
#import "CALayer+AnimationCompletion.h"

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
@interface SDSCardsFireProgressView ()

@property(nonatomic, copy) NSArray* imgNames;
@property(nonatomic) BOOL stopped;

@end

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
@implementation SDSCardsFireProgressView

#define kAnimationDuration 1.

/////////////////////////////////////////////////////////////////////////////////////////
- (CABasicAnimation*)animationForIndex:(short)index {
    
    double rotation = [[[self.layer layerByName:[self.imgNames objectAtIndex:index]] valueForKeyPath:@"transform.rotation.z"] floatValue];
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setDuration:kAnimationDuration];
    [animation setAutoreverses:NO];
    [animation setRepeatCount:1];
    if (index == 2)
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :0.0 :0.55 :1.0];
    if (index == 1)
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :0.0 :0.4 :1.0];
    if (index == 0)
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.17 :0.0 :0.3 :1.0];
    [animation setFromValue:[NSNumber numberWithDouble:rotation]];
    [animation setToValue:[NSNumber numberWithDouble:rotation - M_PI*2]];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    [animation setValue:@"animation" forKey:@"animationKey"];
    
    return animation;
}

/////////////////////////////////////////////////////////////////////////////////////////
- (void)animate:(id)sender {
    
    for (NSString* name in self.imgNames) {
        CALayer* layer = [self.layer layerByName:name];
        [layer addAnimation:[self animationForIndex:[self.imgNames indexOfObject:name]]
                     forKey:@"layerRotation"
                 completion:^(BOOL b) {
                     double rotation = [[layer valueForKeyPath:@"transform.rotation.z"] floatValue];
                     layer.transform = CATransform3DRotate(CATransform3DIdentity, rotation - M_PI*2, 0, 0, 1.0);
                 }];
    }
    if (!self.stopped) {
        float delay = sender?0:kAnimationDuration * 1.33;
        [self performSelector:@selector(animate:) withObject:nil afterDelay:delay];
    }
}

/////////////////////////////////////////////////////////////////////////////////////////
- (void)addImage:(NSString*)imgName {
    
    UIImage* img = [UIImage imageNamed:imgName];
    CALayer* imgLayer = [CALayer layer];
    imgLayer.bounds = (CGRect){CGPointZero, img.size};

    imgLayer.contents = (id)img.CGImage;
    imgLayer.position = self.center;
    imgLayer.name = imgName;
    
    [self.layer addSublayer:imgLayer];
}

/////////////////////////////////////////////////////////////////////////////////////////
- (void)start {
    
    self.stopped = NO;
    [self performSelector:@selector(animate:) withObject:self afterDelay:0.0];
}

/////////////////////////////////////////////////////////////////////////////////////////
- (void)stop {

    self.stopped = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

/////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithImages:(NSArray*)imageNames {
 
    if ((self = [super initWithFrame:CGRectZero])) {
        
        self.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |
                                 UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
        self.imgNames = imageNames;
        for (NSString* name in [self.imgNames reverseObjectEnumerator])
            [self addImage:name];
    }
    return self;
}

/////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    
    [self stop];
    self.imgNames = nil;
    [super dealloc];
}

@end

