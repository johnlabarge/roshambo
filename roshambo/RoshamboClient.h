//
//  RoshamboClient.h
//  roshambo
//
//  Created by La Barge, John on 2/7/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoshamboClient : NSObject
-(void) throw:(NSString *)playerThrow onResult:(void(^)(NSDictionary *))gameResult;
@end
