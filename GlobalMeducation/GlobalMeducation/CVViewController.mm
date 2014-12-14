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
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, retain) CvVideoCamera *videoCamera;
@end

@implementation CVViewController
@synthesize videoCamera;
@synthesize imageView;
@synthesize startButton;
@synthesize imageView2;
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
    Mat tiny_image;
    
    CascadeClassifier classifier;
    CascadeClassifier classifier2;
    
    pyrDown(image, image_copy);
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"haarcascade_lefteye_2splits" ofType:@"xml"];
    
    classifier = cv::CascadeClassifier([fileName UTF8String]);
    
    cvtColor(image, image_copy, CV_BGRA2GRAY);
    
    classifier.detectMultiScale(image_copy, objects);
    
    // display bounding rectangles around the detected objects
    for( vector<cv::Rect>::const_iterator r = objects.begin(); r != objects.end(); r++) {
        
           cv::rectangle(image, cvPoint( r->x - r->width/2, r->y - r->height/2), cvPoint( r->x + r->width, r->y +r->height/2 ), Scalar(0,0,255,255));
        
        IplImage img = (IplImage)tiny_image;
        
        cvRect roi = CGRectMake(r->x - r->width/2, r->y - r->height/2, r->x + r->width, r->y + r->height/2);
        //tiny_image = image(r);
        
        cvSetImageROI(img,)
        
//        CGRect aRect = image[
        //UIImage *roi_image = [self captureScreenInRect:aRect];
        
//        imageView.image = roi_image;
        
        NSLog(@"x: %d y: %d",r->x,r->y);
        
        //UIImage *roi_color =
        //frame[y:y+h, x:x+w]
        
    }
    
    
    //cvtColor(image, image_copy,CV_BGRA2BGR);
    //bitwise_not(image_copy, image_copy);
    //cvtColor(image_copy, image, CV_BGR2BGRA);
    
}


- (UIImage *)captureScreenInRect:(CGRect)captureFrame
{
    
    CALayer *layer;
    layer = self.view.layer;
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
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
