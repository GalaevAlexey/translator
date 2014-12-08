//
//  TranslatedWordVC.h
//  translater
//
//  Created by Alexey Galaev on 05/12/14.
//  Copyright (c) 2014 me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TranslatedWordHistory : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSString *history;
@property (nonatomic, strong) NSString *word;
@end
