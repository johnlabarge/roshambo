//
//  Game.h
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PreviousGame.h"
#import "RoshamboAppDelegate.h"

@interface Game : NSObject
-(void)throw:(NSString *)player onResult:(void(^)(NSDictionary *))gameResult onError:(void(^)(NSString *))errorOccurred;
@end
