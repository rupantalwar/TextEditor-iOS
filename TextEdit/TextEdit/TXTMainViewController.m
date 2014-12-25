//
//  TXTMainViewController.m
//  TextEdit
//
//  Created by Rupan Talwar on 9/23/14.
//  SUID: 402408828
//  Copyright (c) 2014 Rupan Talwar. All rights reserved.
//

#import "TXTMainViewController.h"



@interface TXTMainViewController ()

@end

@implementation TXTMainViewController

NSString *fileName;
bool fileCheck = false;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(TXTFlipsideViewController *)controller
{
    self.text.textColor = [UIColor colorWithRed: controller.redIntensity.value
                                         green: controller.greenIntensity.value
                                          blue: controller.blueIntensity.value
                                         alpha: 1];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        NSLog(@"in prepareForSegue");
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.text resignFirstResponder];
}

- (IBAction)openFile:(id)sender
{
    UIAlertView * openAlert = [[UIAlertView alloc] initWithTitle:@"Open" message:@"Open a file" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Open", nil];
    openAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    openAlert.tag = 1 ;
    [openAlert show];
}

- (IBAction)saveAsData:(id)sender
{
    UIAlertView * saveAlert = [[UIAlertView alloc] initWithTitle:@"Save As" message:@"Save to file" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    saveAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    saveAlert.tag =2 ;
    [saveAlert show];
    if(fileCheck == true){
        [saveAlert textFieldAtIndex:0].text = fileName;
        
    }
}

- (IBAction)saveData:(id)sender
{
    
    UIAlertView * saveDataAlert = [[UIAlertView alloc] initWithTitle:@"Save" message:@"Save to file" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    saveDataAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    saveDataAlert.tag =2 ;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath;
    
    if(fileCheck == true)
    {
    filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        [[_text text] writeToFile:filePath atomically:true encoding:NSStringEncodingConversionAllowLossy error:nil];
        
    UIAlertView * saveAlert = [[UIAlertView alloc] initWithTitle:@"Save" message:[@"File Saved to:" stringByAppendingString:fileName] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    
    [saveAlert show];
        
    }
    else
    {
        [saveDataAlert show];
    }
}

- (IBAction)insertData:(id)sender
{
    
    UIAlertView * insertDataAlert = [[UIAlertView alloc] initWithTitle:@"Insert" message:@"Insert to file:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    insertDataAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    insertDataAlert.tag=3;
    [insertDataAlert show];
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath;
    
    if(alertView.tag==1 && buttonIndex ==1){
       
        fileName = (NSString*)[alertView textFieldAtIndex:0].text;
        filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        
        if(![manager fileExistsAtPath:filePath]){
            
            UIAlertView * fileDoesntExistAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File Doesnt Exist" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            
            [fileDoesntExistAlert show];
            fileName = @"";
            
        }
        else{
            fileCheck = true;
            self.navigationItem.title = fileName;
            [_text  setText: [NSString stringWithContentsOfFile:filePath encoding: NSStringEncodingConversionAllowLossy error: nil] ] ;
        }
        
    }
    
    if(alertView.tag==2 && buttonIndex ==1){
        
        if(fileCheck == false){
            fileName = (NSString*)[alertView textFieldAtIndex:0].text;
        
        filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        if (![manager fileExistsAtPath:filePath]) {
            
            if([manager createFileAtPath:filePath contents:(NSData*)[_text text]  attributes:nil]){
                
                NSLog(@"Created the File Successfully.");
                
            }
            else {
                NSLog(@"Failed to Create the File");
            }
            
        }
        else{
            
            [[_text text] writeToFile:filePath atomically:true encoding:NSStringEncodingConversionAllowLossy error:nil];
            
        }
        
        }
        
        
        
    }
    
    if(alertView.tag==3 && buttonIndex ==1)
    {
        if (![manager fileExistsAtPath:filePath]) {

            
                filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSStringEncodingConversionAllowLossy error:nil];
            
                _text.text=[_text.text stringByAppendingString:content];
        
        }
        else{
            UIAlertView * fileDoesntExistInsertAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File Doesnt Exist" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            
            [fileDoesntExistInsertAlert show];

        }
    }
  
}


@end
