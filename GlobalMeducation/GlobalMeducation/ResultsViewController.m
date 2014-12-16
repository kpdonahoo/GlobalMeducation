//
//  ResultsViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/15/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "ResultsViewController.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface ResultsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *mazeSeconds;
@property (weak, nonatomic) IBOutlet UILabel *dinosaurSeconds;
@property (weak, nonatomic) IBOutlet UILabel *bookSeconds;
@property (weak, nonatomic) IBOutlet UILabel *threeSeconds;

@end

@implementation ResultsViewController
@synthesize background;
@synthesize mazeSeconds;
@synthesize dinosaurSeconds;
@synthesize bookSeconds;
@synthesize threeSeconds;
@synthesize mazeSecondz;
@synthesize bookSecondz;
@synthesize dinoSecondz;
@synthesize threeSecondz;
AVAudioPlayer *win;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    background.alpha = 0.0;
    mazeSeconds.alpha = 0.0;
    bookSeconds.alpha = 0.0;
    dinosaurSeconds.alpha = 0.0;
    threeSeconds.alpha = 0.0;
    
    mazeSeconds.text = mazeSecondz;
    dinosaurSeconds.text = dinoSecondz;
    bookSeconds.text = bookSecondz;
    threeSeconds.text = threeSecondz;
    
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"Medal"
                                               ofType:@"wav"]];
    
    win = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
    
    [win play];
    
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{ background.alpha = .8;  }
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:2.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeSeconds.alpha = 1.0;  }
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:6.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{bookSeconds.alpha = 1.0;  }
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:4.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{dinosaurSeconds.alpha = 1.0;  }
                     completion:nil];
    
    [UIView animateWithDuration:3.0
                          delay:8.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{threeSeconds.alpha = 1.0;  }
                     completion:nil];
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
