//
//  Entity.h
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PreviousGame : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * result;
@property (nonatomic, retain) NSString * player;
@property (nonatomic, retain) NSString * computer;

@end
