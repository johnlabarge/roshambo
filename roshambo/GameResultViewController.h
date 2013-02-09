//
//  GameResultViewController.h
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameResultViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *winnerThrow;
@property (nonatomic, strong) IBOutlet UIImageView *loserThrow;
@property (nonatomic, strong) IBOutlet UILabel *winnerLabel;
@property (nonatomic, strong) IBOutlet UILabel *loserLabel;
@property (nonatomic, strong) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) IBOutlet UILabel *beatsOrTies;

-(IBAction) close:(id)sender;
@end
