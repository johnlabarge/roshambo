//
//  PlayVC.h
//  roshambo
//
//  Created by La Barge, John on 2/7/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayVC : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) IBOutlet UIPickerView * throwPicker;
@property (nonatomic, strong) UIImageView * rock;
@property (nonatomic, strong) UIImageView * paper;
@property (nonatomic, strong) UIImageView * scissors;
@property (nonatomic, strong) NSString * playerThrow;
+(NSArray*) throws;

@end
