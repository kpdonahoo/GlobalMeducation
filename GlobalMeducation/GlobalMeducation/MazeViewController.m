//
//  MazeViewController.m
//  GlobalMeducation
//
//  Created by Amanda Doyle on 12/14/14.
//  Copyright (c) 2014 Sharkbait. All rights reserved.
//

#import "MazeViewController.h"

@interface MazeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mazeBackground;
@property (weak, nonatomic) IBOutlet UIImageView *message;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@end

@implementation MazeViewController
@synthesize mazeBackground;
@synthesize message;
@synthesize continueButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    mazeBackground.alpha = 0.0;
    continueButton.alpha = 0.0;
    message.alpha = 0.0;
    
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{mazeBackground.alpha = 1.0;}
                     completion:nil];
    
    
    [UIView animateWithDuration:6.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{message.alpha = .8;}
                     completion:nil];
    
    
    [UIView animateWithDuration:6.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{continueButton.alpha = 1.0;}
                     completion:nil];
    
    
}

- (IBAction)toISpy:(id)sender {
    [self performSegueWithIdentifier:@"toISpy" sender:self];
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
