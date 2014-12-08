//
//  TranslatedWordVC.m
//  translater
//
//  Created by Alexey Galaev on 05/12/14.
//  Copyright (c) 2014 me. All rights reserved.
//

#import "TranslatedWordVC.h"
#import "AllData.h"
@interface TranslatedWordVC () {
    
    IBOutlet UIView *trView;
    IBOutlet UIButton *backButton;
    IBOutlet UILabel *userWord;
    IBOutlet UILabel *langLabel;
    IBOutlet UITextView *translate;
    NSMutableArray *trwords;
    NSMutableArray *history;
    NSString * answer;
    NSString * answerplus;
}

@end

@implementation TranslatedWordVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    history = [[NSMutableArray alloc]init];
    trwords = [[NSMutableArray alloc]init];
    trView.layer.cornerRadius = 10;
    trView.clipsToBounds = YES;
    switch ([AllData sharedInstance].lang) {
        case 1:
            langLabel.text = @"ENG";
            break;
        case 2:
            langLabel.text = @"RUS";
            break;
        case 3:
            langLabel.text = @"DEU";
            break;
        case 4:
            langLabel.text = @"FRA";
            break;
            default:
            break;
    }
     userWord.text = [AllData sharedInstance].word;
    if([[NSString stringWithFormat:@"%@",userWord.text ]isEqualToString:@""])
         userWord.text = @"Введите слово";
    
    trwords = [AllData sharedInstance].words;
    answer = @"";
    answerplus = @"";
    translate.text =@"НЕТ ДАННЫХ";
   
   if (trwords.count>1){
        
    for (int i = 0; i<trwords.count-1;
         i++){
       
        NSString *someString = [NSString stringWithFormat:@"%d. %@\n", i+1, trwords[i]];
        answerplus = [answer stringByAppendingString:someString];
        answer = answerplus;
       }
     translate.text = answerplus;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backPressed:(id)sender {
    if (trwords.count) {
        
        if([[AllData sharedInstance].history count]<=5)
        {
            [[AllData sharedInstance].history addObject:translate.text];
            NSLog(@"%@",[AllData sharedInstance].history);
            
        }
    
    
      }
    [AllData sharedInstance].words = nil;
    translate.text =@"";
    [self dismissViewControllerAnimated:YES completion:nil];


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
