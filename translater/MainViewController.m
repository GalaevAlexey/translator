//
//  ViewController.m
//  translater
//
//  Created by Alexey Galaev on 05/12/14.
//  Copyright (c) 2014 me. All rights reserved.
//

#import "MainViewController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLConnectionOperation.h"
#import "AFURLRequestSerialization.h"
#import "HTMLParser.h"
#import "HTMLNode.h"
#import "TranslateCell.h"
#import "TranslationTypeVC.h"
#import "AllData.h"
#import "TranslatedWordHistory.h"
@interface MainViewController () {
    
    IBOutlet UITableView *mytable;
    
    NSMutableData *receiveData;
    int inputLang;
    int oututLang;
    NSString* wordToTranslate;
    NSMutableArray *translatedWords;
    NSMutableArray *tabletranslation;
    NSString *translatedHistory;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mytable.layer.cornerRadius = 10;
    mytable.clipsToBounds = YES;
    tabletranslation  = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [mytable reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editBegin:(id)sender {
    
    self.tranWorldTextField.text = @"";
}
- (IBAction)editingend:(id)sender {
    
    wordToTranslate = self.tranWorldTextField.text;
    [AllData sharedInstance].word = self.tranWorldTextField.text;
}


-(void)setType:(NSString*)spec andLang1:(int)l1 andLang2:(int)l2; {
    
    NSString *specadd = [NSString stringWithString:spec];
    
    [_tranTypeButton setTitle:specadd forState:UIControlStateNormal];
    
    inputLang =l1;
   
    oututLang =l2;
    [AllData sharedInstance].lang = l2;
    
   // NSLog(@"ПАРАМЕТРЫ%d%d",l1,l2);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSLog(@"%@",[AllData sharedInstance].history);
    return [[AllData sharedInstance].history count];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    translatedHistory = [AllData sharedInstance].history[indexPath.row];
    [self performSegueWithIdentifier:@"history" sender:self];


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        static NSString *CellIdentifier = @"Cell";
    
        TranslateCell *cell = [mytable dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
         
            cell = [[TranslateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        }
    cell.word.text = [AllData sharedInstance].history[indexPath.row];
   return cell;
    
}

- (IBAction)translate:(id)sender{
    [_translateButton setEnabled:NO];
    [AllData sharedInstance].words = nil;
    wordToTranslate = self.tranWorldTextField.text;
    [AllData sharedInstance].word = self.tranWorldTextField.text;
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.multitran.ru/c/m.exe?l1=%d&l2=%d&s=%@",
                           inputLang,
                           oututLang,
                           wordToTranslate];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSLog(@"URL---\n%@",url );
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"GET"];
    [rq setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [rq setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    NSURLConnection *feedConnection = [[NSURLConnection alloc] initWithRequest:rq delegate:self];
    [feedConnection start];

}




//MANAGING CONNECTION
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error-%@",error);
    
    
    
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        
        NSLog(@"ошибка подключения к сети %@",error);
    }
    else
    {
        NSLog(@"ошибка получения данных %@",error);
    }
    
}



-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"url - %@ status - %i", httpResponse.URL, (int)[httpResponse statusCode]);
    NSLog(@"desc - %@", httpResponse.debugDescription);
    
    
    
    if([httpResponse statusCode]<300)
    {
        // все ок. Начинаем прием данных
        receiveData = [[NSMutableData alloc] initWithCapacity:2000];
        
    }
    else
    {
        // сервер вернул ошибку
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[AllData sharedInstance].history removeObjectAtIndex:indexPath.row];
        [mytable reloadData];
            
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    translatedWords = [[NSMutableArray alloc]init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error = nil;
        //Запускаем HTML парсер
        NSString *myString = [[NSString alloc]initWithData:receiveData encoding:11];
        //[myString UTF8String];
        HTMLParser *parser = [[HTMLParser alloc] initWithString:myString error:&error];
        
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        HTMLNode *bodyNode = [parser body];
        
        // NSLog(@"%@", myString );
        NSArray *spanNodes = [bodyNode findChildTags:@"a"];
        //NSLog(@"%@", spanNodes );
        for (HTMLNode *spanNode in spanNodes) {
            
            if ([[spanNode getAttributeNamed:@"href"] containsString:@"s1="]) {
                
                NSString *world = [NSString stringWithFormat:@"%@",[spanNode contents]];
                //[world UTF8String];
                [translatedWords addObject:world];
                //NSLog(@"%@",world);
            }
           // NSLog(@"%@",translatedWords);
        }
           [AllData sharedInstance].words = translatedWords;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            /* Код, который выполниться в главном потоке */
                [_translateButton setEnabled:YES];
            [self performSegueWithIdentifier:@"look" sender:self];
            
        });
    });

    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tRtype"])
    {
    TranslationTypeVC *ttyp = [segue destinationViewController];
    ttyp.specD = (id)self;
    }
    if ([segue.identifier isEqualToString:@"history"])
    {
        TranslatedWordHistory *twh = [segue destinationViewController];
        twh.history = translatedHistory;
        twh.word = wordToTranslate;
    }

    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end