//
//  TranslationTypeVC.h
//  translater
//
//  Created by Alexey Galaev on 05/12/14.
//  Copyright (c) 2014 me. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SpecDelegate <NSObject>

-(void)setType:(NSString*)spec andLang1:(int)l1 andLang2:(int)l2;

@end

@interface TranslationTypeVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id <SpecDelegate> specD;

@end
