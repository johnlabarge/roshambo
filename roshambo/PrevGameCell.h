//
//  PrevGameCell.h
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrevGameCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * dateLabel;
@property (nonatomic, strong) IBOutlet UILabel * winLoseOrTieLabel;
@property (nonatomic, strong) IBOutlet UIImageView * playerThrowImage;
@property (nonatomic, strong) IBOutlet UIImageView * computerThrowImage;
@end
