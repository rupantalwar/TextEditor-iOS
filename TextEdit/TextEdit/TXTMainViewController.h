//
//  TXTMainViewController.h
//  TextEdit
//
//  Created by Rupan Talwar on 9/23/14.
//  SUID: 402408828
//  Copyright (c) 2014 Rupan Talwar. All rights reserved.

#import "TXTFlipsideViewController.h"

@interface TXTMainViewController : UIViewController <TXTFlipsideViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *text;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)openFile:(id)sender;
- (IBAction)saveAsData:(id)sender;
- (IBAction)saveData:(id)sender;
- (IBAction)insertData:(id)sender;


@end
