//
//  ViewController.h
//  GlobalMeducation
//
//  Created by Kevin Donahoo on 12/9/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoAnalgesic.h"
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
@interface ViewController : UIViewController

@property (strong, nonatomic) VideoAnalgesic *videoManager;
@property (strong, nonatomic) CIVector *center;
@end

