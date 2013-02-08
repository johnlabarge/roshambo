//
//  ShakeView.h
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeView : UIView
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
- (BOOL)canBecomeFirstResponder;
@end
