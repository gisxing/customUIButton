//
//  cardButton.m
//  27-magic
//
//  Created by gisxing on 14-1-9.
//  Copyright (c) 2014年 gisxing. All rights reserved.
//

#import "cardButton.h"
#import "Common.h"

@implementation cardButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Get width of button
        self.backgroundColor = [UIColor redColor];
        double buttonWidth = self.frame.size.width;
        double buttonHeight = self.frame.size.height;
        
        // Initialize buttonLabel
        UILabel *labelTop = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, buttonWidth, buttonHeight)];
        labelTop.backgroundColor = [UIColor blueColor];
    
        NSLog(@"init a button");
        

        labelTop.text = @"test";
        [self addSubview:labelTop];
        
        
        
    }
    return self;
}


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
        
        /*
        // handle a lable on it
        double buttonWidth = self.frame.size.width;
        double buttonHeight = self.frame.size.height;
        
        // Initialize buttonLabel
        UILabel *labelTop = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, buttonWidth, buttonHeight)];
        labelTop.backgroundColor = [UIColor blueColor];
        labelTop.alpha = 0.2;
        
        //NSLog(@"init a button");
        labelTop.text = @"test";
        [self addSubview:labelTop];
        */ 
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * color = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:self.brightness alpha:1.0];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, self.bounds);
     */
    
    CGFloat actualBrightness = self.brightness;
    if (self.state == UIControlStateHighlighted) {
        actualBrightness -= 0.10;
    }
    
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *  blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor *  highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    UIColor *  highlightStop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    UIColor *  shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    // self.brightness is now acutalBrightness
    UIColor * outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*actualBrightness alpha:1.0];
    UIColor * outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.80*actualBrightness alpha:1.0];
    UIColor * innerStroke = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.80*actualBrightness alpha:1.0];
    UIColor * innerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.90*actualBrightness alpha:1.0];
    UIColor * innerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.70*actualBrightness alpha:1.0];
    
    CGFloat outerMargin = 5.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
    
    CGFloat innerMargin = 3.0f;
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 6.0);
    
    CGFloat highlightMargin = 2.0f;
    CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
    CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 6.0);
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, outerTop.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
        CGContextAddPath(context, outerPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, outerRect, outerTop.CGColor, outerBottom.CGColor);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, innerRect, innerTop.CGColor, innerBottom.CGColor);
    CGContextRestoreGState(context);
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 4.0);
        CGContextAddPath(context, outerPath);
        CGContextAddPath(context, highlightPath);
        CGContextEOClip(context);
        drawLinearGradient(context, outerRect, highlightStart.CGColor, highlightStop.CGColor);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, innerStroke.CGColor);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    CGContextAddPath(context, innerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
    CFRelease(innerPath);
    CFRelease(highlightPath);
    
    
}

-(void) setHue:(CGFloat)hue
{
    _hue = hue;
    [self setNeedsDisplay];
}

-(void) setSaturation:(CGFloat)saturation
{
    _saturation = saturation;
    [self setNeedsDisplay];
}

-(void) setBrightness:(CGFloat)brightness
{
    _brightness = brightness;
    [self setNeedsDisplay];
}

- (void)hesitateUpdate
{
    [self setNeedsDisplay];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
