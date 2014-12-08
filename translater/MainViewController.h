//
//  ViewController.h
//  translater
//
//  Created by Alexey Galaev on 05/12/14.
//  Copyright (c) 2014 me. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol surveyDelegate <NSObject>

//-(void)passSurvey:(NSDictionary*)survey;
@end

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate >

@property (strong, nonatomic) IBOutlet UIButton *translateButton;

@property (strong, nonatomic) IBOutlet UIButton *tranTypeButton;
@property (strong, nonatomic) IBOutlet UITextField *tranWorldTextField;

@property (nonatomic, strong) id <surveyDelegate> surDelegate;

@end




