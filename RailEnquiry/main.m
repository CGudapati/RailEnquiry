//
//  main.m
//  RailEnquiry
//
//  Created by Venkat on 01/01/15.
//  Copyright (c) 2015 Gudapati Naga Venkata Chaitanya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BOOL __block done = NO;
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        NSString * BaseURLString = @"http://api.erail.in/pnr?key=599c66c2-493d-47e6-abe9-af2a364ae81b&pnr=2629007687";

        
        NSURL *url = [NSURL URLWithString:BaseURLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *statusDict = (NSDictionary *) responseObject;
            NSLog(@"%@", statusDict);
            
        
            NSDictionary *resultDictionary = [statusDict objectForKey:@"result"];
            NSDictionary *passDict = [resultDictionary objectForKey:@"passengers"];
            NSLog(@"%@", passDict);
            
            NSUInteger numberofPassengers = [passDict count];
            NSMutableArray *arrayOfPassengers = [[NSMutableArray alloc] init];
            for (int i = 1; i<=numberofPassengers; ++i) {
                NSMutableString *baseString = [NSMutableString stringWithString:@"Passenger"];
                [baseString appendString:[NSString stringWithFormat:@"%i", i]];
                [arrayOfPassengers addObject:baseString];
            }
            NSMutableArray *arrayofStatuses = [[NSMutableArray alloc] init];
            for (NSString *random in passDict) {
                [arrayofStatuses addObject:random];
            }
            
            
            NSDictionary *passengerDictionary = [[NSDictionary alloc] initWithObjects:arrayofStatuses forKeys:arrayOfPassengers];
            NSLog(@"%@", passengerDictionary);
            
            NSString *class;
            class = [resultDictionary objectForKey:@"cls"];
            NSString *eticket;
            eticket =  [resultDictionary objectForKey:@"eticket"];
            NSString *destination;
            destination = [resultDictionary objectForKey:@"to"];
            NSString *pnr;
            pnr = [resultDictionary objectForKey:@"pnr"];
            NSString *journeyDate;
            journeyDate = [resultDictionary objectForKey:@"journey"];
            NSString *boardingStation;
            boardingStation = [resultDictionary objectForKey:@"brdg"];
            NSString *chartingStatus;
            chartingStatus = [resultDictionary objectForKey:@"chart"];
            NSString *bookedFrom;
            bookedFrom = [resultDictionary objectForKey:@"from"];
            NSString *trainNo;
            trainNo = [resultDictionary objectForKey:@"trainno"];
            NSString *trainName;
            trainName = [resultDictionary objectForKey:@"name"];
            NSLog(@"********************************************");
            NSLog(@"PNR              : %@", pnr);
            NSLog(@"Booking Station  : %@", bookedFrom);
            NSLog(@"Boarding Station : %@", boardingStation);
            NSLog(@"Destination      : %@", destination);
            NSLog(@"Journey Date     : %@", journeyDate);
            NSLog(@"Class            : %@", class);
            NSLog(@"Train No         : %@", trainNo);
            NSLog(@"Train Name       : %@", trainName);
            NSLog(@"Charting Status  : %@", chartingStatus);
            NSLog(@"Booking Status   : %@", passengerDictionary);
            NSLog(@"********************************************");
            
//            NSLog(@"YES");
            done = YES;

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"NO!");
            done = YES;
            
        }];
        [operation start];
        
        
        while (!done && [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
            // this is intentionally blank
        }
    }
    return 0;
}
