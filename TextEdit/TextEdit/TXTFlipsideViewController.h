//
//  TXTFlipsideViewController.h
//  TextEdit
//
//  Created by Rupan Talwar on 9/23/14.
//  SUID: 402408828
//  Copyright (c) 2014 Rupan Talwar. All rights reserved.

#import <UIKit/UIKit.h>

@class TXTFlipsideViewController;

@protocol TXTFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(TXTFlipsideViewController *)controller;
@end

@interface TXTFlipsideViewController : UIViewController

@property (weak, nonatomic) id <TXTFlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *redIntensity;
@property (weak, nonatomic) IBOutlet UISlider *greenIntensity;
@property (weak, nonatomic) IBOutlet UISlider *blueIntensity;
@property (weak, nonatomic) IBOutlet UITextField *preview;

- (IBAction)done:(id)sender;
- (IBAction)previewColor:(id)sender;

@end
