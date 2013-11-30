//
//  SCGIFImageView.m
//  TestGIF
//
//  Created by shichangone on 11-7-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SCGIFImageView.h"
#import <ImageIO/ImageIO.h>

@implementation SCGIFImageFrame
@synthesize image = _image;
@synthesize duration = _duration;

- (void)dealloc
{

}

@end

@interface SCGIFImageView ()



- (void)showNextImage;

@end

@implementation SCGIFImageView
@synthesize imageFrameArray = _imageFrameArray;
@synthesize timer = _timer;

- (void)dealloc
{
    NSLog(@"2222 dealloc");
    
    [self resetTimer];

    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

- (void)resetTimer {
    if (_timer && _timer.isValid) {
        [_timer invalidate];
        [_timer fire];
    }
    self.timer = nil;
}

- (void)setData:(NSData *)imageData {
    if (!imageData) {
        return;
    }
    [self resetTimer];
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray* tmpArray = [NSMutableArray array];
    @autoreleasepool {
        for (size_t i = 0; i < count; i++) {
            SCGIFImageFrame* gifImage = [[SCGIFImageFrame alloc] init] ;
            
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            gifImage.image = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
            
            NSDictionary* frameProperties = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
            gifImage.duration = [[[frameProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
            gifImage.duration = MAX(gifImage.duration, 0.01);
            
            [tmpArray addObject:gifImage];
            
            CGImageRelease(image);
        }
    }
    
    CFRelease(source);
    
    self.imageFrameArray = nil;
    if (tmpArray.count > 1) {
        self.imageFrameArray = tmpArray;
        _currentImageIndex = -1;
        [self showNextImage];
    } else {
        self.image = [UIImage imageWithData:imageData];
    }
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    [self resetTimer];
    self.imageFrameArray = nil;
}

- (void)showNextImage {
    _currentImageIndex = (++_currentImageIndex) % _imageFrameArray.count;
    NSLog(@"_currentImageIndex = %d",_currentImageIndex);
    SCGIFImageFrame* gifImage = [_imageFrameArray objectAtIndex:_currentImageIndex];
    [super setImage:[gifImage image]];
    [self resetTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:gifImage.duration target:self selector:@selector(showNextImage) userInfo:nil repeats:NO];
}

@end
