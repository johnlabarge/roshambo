//
//  Game.m
//  roshambo
//
//  Created by La Barge, John on 2/8/13.
//  Copyright (c) 2013 La Barge, John. All rights reserved.
//

#import "Game.h"

@interface Game ()
-(NSURL *) urlForThrow:(NSString *)throw;
-(void) saveGame:(NSDictionary *)gameResult;

@end

@implementation Game

-(void)throw:(NSString *)player onResult:(void(^)(NSDictionary *))gameResult onError:(void(^)(NSString *)) errorOccurred
{
    NSURL * urlForThrow = [self urlForThrow:player];
      
    NSURLRequest * req = [NSURLRequest requestWithURL:urlForThrow];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    __block Game *blocksafeSelf = self;
[NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse * resp, NSData * data, NSError * error) {
        if (data.length > 0 && error == nil){
            NSError * error;
            NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (error != nil) {
                [blocksafeSelf saveGame:result];
                gameResult(result);
            } else {
                errorOccurred(@"Computer Opponent out sick.");
            }
                
        } else {
            errorOccurred(@"Couldn't reach opponent.");
        }
        
    }];
}

-(NSURL *) urlForThrow:(NSString *) throw
{
   NSString *host = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"host"];
   return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",host,throw]];
}

-(void) saveGame:(NSDictionary *)gameResult
{
    NSManagedObjectContext * moc = [(RoshamboAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];

    PreviousGame * prevGame = (PreviousGame *) [NSEntityDescription insertNewObjectForEntityForName:@"PreviousGame" inManagedObjectContext:moc];
    prevGame.date = [NSDate date];
    prevGame.player = [gameResult objectForKey:@"Player"];
    prevGame.computer = [gameResult objectForKey:@"Computer"];
    prevGame.result = [gameResult objectForKey:@"Result"];
    
    NSError * error; 
    if (![moc save:&error]) {
        NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
        NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        if(detailedErrors != nil && [detailedErrors count] > 0) {
            for(NSError* detailedError in detailedErrors) {
                NSLog(@"  DetailedError: %@", [detailedError userInfo]);
            }
        }
        else {
            NSLog(@"  %@", [error userInfo]);
        }
    }
    

    
}


@end


