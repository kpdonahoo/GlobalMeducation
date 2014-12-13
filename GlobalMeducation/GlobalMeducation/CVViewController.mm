//
//  CVViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/13/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "CVViewController.h"
#import <opencv2/highgui/cap_ios.h>
#import <opencv2/opencv.hpp>
//#import "haarcascade_frontalface_alt2.xml"

using namespace cv;

@interface CVViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, retain) CvVideoCamera *videoCamera;
@end

@implementation CVViewController
@synthesize videoCamera;
@synthesize imageView;
@synthesize startButton;
vector<cv::Rect> objects;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
}

-(void)processImage:(Mat&)image {
    Mat image_copy;
    //cvtColor(image, image_copy,CV_BGRA2BGR);
    //bitwise_not(image_copy, image_copy);
    
    CascadeClassifier classifier;
    
    pyrDown(image, image_copy);
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt2" ofType:@"xml"];
    classifier = cv::CascadeClassifier([fileName UTF8String]);
    cvtColor(image, image_copy, CV_BGRA2GRAY);
    
    classifier.detectMultiScale(image_copy, objects);
    
    // display bounding rectangles around the detected objects
    for( vector<cv::Rect>::const_iterator r = objects.begin(); r != objects.end(); r++) {
    
        NSLog(@"I see a face");
        
        /*    cv::rectangle(image, cvPoint( r->x, r->y ), cvPoint( r->x + r->width, r->y + r->height ), Scalar(0,0,255,255));*/
    }

    //cvtColor(image_copy, image, CV_BGR2BGRA);
}

- (IBAction)startPressed:(id)sender {
    [self.videoCamera start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
