//
//  GameResultViewController.m
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Initialized result ");// Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"game result loaded");
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
