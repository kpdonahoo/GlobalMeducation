//
//  ViewController.m
//  GlobalMeducation
//
//  Created by Kevin Donahoo on 12/9/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//hi kevin
float radius;

-(VideoAnalgesic*)videoManager{
    if(!_videoManager){
        _videoManager = [VideoAnalgesic captureManager];
        _videoManager.preset = AVCaptureSessionPresetMedium;
        [_videoManager setCameraPosition:AVCaptureDevicePositionFront];
    }
    return _videoManager;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = nil;
    radius = 150.0;
    
    self.center = [CIVector vectorWithX:self.view.bounds.size.height/2.0 - radius/2.0 Y:self.view.bounds.size.width/2.0+radius/2.0];
    
    
    __block CIFilter *filter = [CIFilter filterWithName:@"CICircleSplashDistortion"];
    __block CIFilter *eyeFilter = [CIFilter filterWithName:@"CIBumpDistortion"];
    __block CIFilter *mouthFilter = [CIFilter filterWithName:@"CIPinchDistortion"];
    
    
    
    __block NSDictionary *opts = @{CIDetectorAccuracy: CIDetectorAccuracyLow};
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:self.videoManager.ciContext options:opts];
    
    
    
    [self.videoManager setProcessBlock:^(CIImage *cameraImage){
        
        opts = @{CIDetectorImageOrientation:
                     [VideoAnalgesic ciOrientationFromDeviceOrientation:[UIApplication sharedApplication].statusBarOrientation]};
        
        NSArray *faceFeatures = [detector featuresInImage: cameraImage options:opts];
        
        for(CIFaceFeature *face in faceFeatures ){
            float xx = face.bounds.origin.x + face.bounds.size.height/2;
            float yy = face.bounds.origin.y + face.bounds.size.width/2;
            
            
            [filter setValue:@(yy) forKey:@"inputRadius"];
            
            if (face.hasLeftEyePosition)
            {
                CIVector *leftVect = [CIVector vectorWithX:face.leftEyePosition.x Y:face.leftEyePosition.y];
                [eyeFilter setValue:leftVect forKey:@"inputCenter"];
                [eyeFilter setValue:cameraImage forKey:kCIInputImageKey];
                cameraImage = eyeFilter.outputImage;
            }
            
            if (face.hasRightEyePosition)
            {
                CIVector *rightVect = [CIVector vectorWithX:face.rightEyePosition.x Y:face.rightEyePosition.y];
                [eyeFilter setValue:rightVect forKey:@"inputCenter"];
                [eyeFilter setValue:cameraImage forKey:kCIInputImageKey];
                cameraImage = eyeFilter.outputImage;
            }
            
            if (face.hasMouthPosition)
            {
                CIVector *mouthVect = [CIVector vectorWithX:face.mouthPosition.x Y:face.mouthPosition.y];
                [mouthFilter setValue:mouthVect forKey:@"inputCenter"];
                [mouthFilter setValue:cameraImage forKey:kCIInputImageKey];
                cameraImage = mouthFilter.outputImage;
            }
            
            CIVector *vect = [CIVector vectorWithX:xx Y:yy];
            
            [filter setValue:vect forKey:@"inputCenter"];
            [filter setValue:cameraImage forKey:kCIInputImageKey];
            cameraImage = filter.outputImage;
            
            
            
        }
        
        return cameraImage;
    }];

}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(![self.videoManager isRunning])
        [self.videoManager start];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    /*if(![self.captureManager isRunning]) {
     [self.captureManager stop];
     }*/
    
    if([self.videoManager isRunning])
        [self.videoManager stop];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
