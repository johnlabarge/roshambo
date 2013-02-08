//
//  PlayVC.m
//  roshambo
//
//  Created by La Barge, John on 2/7/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import "PlayVC.h"

@interface PlayVC ()

@end


@implementation PlayVC
@synthesize throwPicker;
@synthesize rock,paper,scissors;

+ (NSArray *) throws {

    static NSArray * throws;

    if (throws == nil) {
      throws = @[@"rock", @"paper", @"scissors"];
    }
    return throws;

}
#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"pickerView delegate...");
    self.playerThrow = [[PlayVC throws] objectAtIndex:(row%3)];

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSLog(@"..viewForRow...%d",row);
    switch (row%3) {
        case 0:
            return self.rock;
        case 1:
            return self.paper;
        case 2:
            return self.scissors;
    }

}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (row) {
        case 0:
            return [[NSAttributedString alloc] initWithString:@"rock"];
        case 1:
            return [[NSAttributedString alloc] initWithString:@"paper"];
        case 2:
            return [[NSAttributedString alloc] initWithString:@"scissors"];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (row) {
        case 0:
            return @"rock";
        case 1:
            return @"paper";
        case 2:
            return @"scissors";
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return  300;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 1000000;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        
        
     
    }
    return self;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"Shake happend …");
    NSInteger randomSelection  = arc4random() % 1000000;
    [self.throwPicker selectRow:randomSelection inComponent:0 animated:YES];
    [self.throwPicker reloadComponent:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.view becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.throwPicker.showsSelectionIndicator = NO;
	// Do any additional setup after loading the view.
    self.rock =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rock.png"]];
    self.rock.frame = CGRectMake(0.0,0.0,300.0,100.0);
    self.rock.contentMode = UIViewContentModeScaleAspectFit;
    
    self.paper =    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.png"]];
    self.paper.contentMode = UIViewContentModeScaleAspectFit;
    self.paper.frame  = CGRectMake(0.0,0.0,300.0,100.0);
    
    self.scissors = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scissors.png"]];
    self.scissors.contentMode = UIViewContentModeScaleAspectFit;
    self.scissors.frame  =CGRectMake(0.0,0.0,300.0,100.0);
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
