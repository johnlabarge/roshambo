//
//  Splash.m
//  roshambo
//
//  Created by La Barge, John on 2/7/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import "Splash.h"

@interface Splash ()
-(void) afterSplash; 
@end

@implementation Splash
@synthesize image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"view did load");
        [super viewDidLoad];
	
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector: @selector(afterSplash) userInfo:nil repeats:NO];

  
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"view did unload"); 
}
-(void) afterSplash
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"roshambo" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"roshambotabs"];
    RoshamboAppDelegate *  appDelegate = [UIApplication sharedApplication].delegate;
    
    [appDelegate.transitionController performSelectorOnMainThread:@selector(transitionToViewController:) withObject:vc waitUntilDone:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
