//
//  DataAPI.h
//  ondochat
//
//  Created by Алексей Галаев on 06/08/14.
//  Copyright (c) 2014 ondoc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AllData : NSObject


+ (AllData*)sharedInstance;



@property (nonatomic, copy) NSString* word;

@property (nonatomic, copy) NSMutableArray* words;

@property (nonatomic, copy) NSMutableArray *history;

@property (nonatomic) int lang;

@end
