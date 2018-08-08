//
//  SafariExtensionViewController.m
//  MyFirstSafariAppExtension
//
//  Created by iceberg on 2018/8/7.
//  Copyright © 2018年 industiousonesoft. All rights reserved.
//

#import "SafariExtensionViewController.h"
#import <AppKit/AppKit.h>

@interface SafariExtensionViewController ()

@property (weak) IBOutlet NSTextField *displayTextField;
@property (weak) IBOutlet NSView *navigationView;
@property (weak) IBOutlet NSView *contentView;

@end

@implementation SafariExtensionViewController

+ (SafariExtensionViewController *)sharedController {
    static SafariExtensionViewController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[SafariExtensionViewController alloc] init];
    });
    return sharedController;
}

- (void)viewDidLoad {
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear {
    NSLog(@"%s", __func__);
}

#pragma mark - Public Methods

- (void)updateDisplayText:(NSString *)text {
    [self.displayTextField setStringValue:text];
    [self.navigationView setHidden:YES];
    [self.contentView setHidden:NO];
}

#pragma mark - IBAction

- (IBAction)buttonDidClicked:(id)sender {
    NSLog(@"%s", __func__);
    
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"MessageFromContainingApp" object:self.displayTextField.stringValue userInfo:nil deliverImmediately:YES];
}

@end
