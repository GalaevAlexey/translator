//
//  TranslationTypeVC.m
//  translater
//
//  Created by Alexey Galaev on 05/12/14.
//  Copyright (c) 2014 me. All rights reserved.
//

#import "TranslationTypeVC.h"

@interface TranslationTypeVC () {
    
    IBOutlet UITableView *mytable;
    NSArray *allTypes;
     NSArray *allTypestopass;
    int l1;
    int l2;
}

@end

@implementation TranslationTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mytable.layer.cornerRadius = 10;
    mytable.clipsToBounds = YES;
    allTypes = @[@"Англиский - Русский",@"Русский - Английский",@"Французский - Русский",@"Русский - Французский",@"Немецкий - Английский",@"Английский - Немецкий"];
    allTypestopass = @[
  @[@1 ,@2],
  @[@2 ,@1],
  @[@4 ,@2],
  @[@2 ,@4],
  @[@3 ,@1],
  @[@1 ,@3]
  ];
                       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return allTypes.count;
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [mytable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", allTypes[indexPath.row]];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    l1 = [allTypestopass[indexPath.row][0]integerValue];
    l2 = [allTypestopass[indexPath.row][1]integerValue];
    [self.specD setType:[allTypes objectAtIndex:indexPath.row] andLang1:l1 andLang2:l2];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //        [AllData sharedInstance].selectedSpec = [[[AllData sharedInstance].dataAllDocSpecializations objectAtIndex:indexPath.row]objectForKey:@"id"];

}
- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
