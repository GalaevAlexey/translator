//
//  TranslatedWordVC.m
//  translater
//
//  Created by Alexey Galaev on 05/12/14.
//  Copyright (c) 2014 me. All rights reserved.
//

#import "TranslatedWordHistory.h"
#import "AllData.h"
@interface TranslatedWordHistory () {
    
    IBOutlet UIView *trView;
    IBOutlet UIButton *backButton;
    IBOutlet UILabel *userWord;
    IBOutlet UILabel *langLabel;
    IBOutlet UITextView *translate;

}

@end

@implementation TranslatedWordHistory

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    trView.layer.cornerRadius = 10;
    trView.clipsToBounds = YES;
  
     userWord.text = _word;

     translate.text = _history;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backPressed:(id)sender {
  
    [self.navigationController popToRootViewControllerAnimated:YES];


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
