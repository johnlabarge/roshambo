//
//  PlayVC.m
//  roshambo
//
//  Created by La Barge, John on 2/7/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import "PlayVC.h"

@interface PlayVC ()
-(void) presentResult:(NSDictionary *)result;
@end


@implementation PlayVC
@synthesize throwPicker;
@synthesize rock,paper,scissors;
@synthesize playerThrow;
@synthesize game,resultView, errorAlert;

+ (NSArray *) throws {

    static NSArray * throws;

    if (throws == nil) {
      throws = @[@"rock", @"paper", @"scissors"];
    }
    return throws;

}
#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"pickerView delegate... did select row");
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
    return self.rock;

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
    return [[NSAttributedString alloc] initWithString:@"rock"];
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
    return @"rock";
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




#pragma mark move the picker on shake
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"Shake happend …");
    NSInteger randomSelection  = arc4random() % 1000000;
    [self.throwPicker selectRow:randomSelection inComponent:0 animated:YES];
    [self.throwPicker reloadComponent:0];
    self.playerThrow = [[PlayVC throws ] objectAtIndex:randomSelection % 3];
}


#pragma mark throw action
-(IBAction) throw
{
    NSLog(@"Player throwing : %@",self.playerThrow);
    __block PlayVC * blockSelf = self;
    [self.game  throw:self.playerThrow
             onResult: ^(NSDictionary * result) {
                 NSLog(@"presenting game result....");
                 [blockSelf performSelectorOnMainThread:@selector(presentResult:) withObject:result waitUntilDone:NO];
             } onError:^(NSString * message) {
                 [blockSelf performSelectorOnMainThread:@selector(alertError:) withObject:message waitUntilDone:NO];
             }
     ];
}
-(void) alertError:(NSString *) message {
    self.errorAlert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self.errorAlert show];
}
-(void) presentResult:(NSDictionary *)result {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"roshambo" bundle:nil];
    self.resultView = [storyboard instantiateViewControllerWithIdentifier:@"GameResult"];
    NSString * theResult = [result objectForKey:@"Result"];
    
    NSString * playerThrow = [result objectForKey:@"Player"];
    NSString * computerThrow = [result objectForKey:@"Computer"];
    NSLog(@"player:%@ computer%@ result:%@",playerThrow, computerThrow, theResult);
    [self presentViewController:self.resultView animated:YES completion:nil];
    if ([theResult isEqualToString:@"win"]) {
        
        self.resultView.resultLabel.text = @"You Win!";
        self.resultView.winnerLabel.text = @"You";
        self.resultView.loserLabel.text = @"Computer";
        self.resultView.beatsOrTies.text=@"beats";
        [self.resultView.winnerThrow setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",playerThrow]]];
        [self.resultView.loserThrow setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",computerThrow]]];
      
    } else if ([theResult isEqualToString:@"lose"]){
        self.resultView.resultLabel.text=@"You Lose.";
        self.resultView.winnerLabel.text=@"Computer";
        self.resultView.loserLabel.text=@"You";
        self.resultView.beatsOrTies.text=@"beats";
        [self.resultView.winnerThrow setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",computerThrow]]];
        [self.resultView.loserThrow setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",playerThrow]]];
    } else {
        self.resultView.resultLabel.text=@"Tie.";
        self.resultView.winnerLabel.text=@"Computer";
        self.resultView.loserLabel.text=@"You";
        self.resultView.beatsOrTies.text=@"ties";
        [self.resultView.winnerThrow setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",computerThrow]]];
        [self.resultView.loserThrow setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",playerThrow]]];
    }


}
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //do nothing
    }
}

#pragma mark ViewController methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
     self.playerThrow = @"rock";
    }
    return self;
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
    
    self.game = [[Game alloc] init];
    self.playerThrow = @"rock";
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
