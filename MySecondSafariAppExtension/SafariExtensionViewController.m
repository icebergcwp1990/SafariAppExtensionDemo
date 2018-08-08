//
//  SafariExtensionViewController.m
//  MySecondSafariAppExtension
//
//  Created by iceberg on 2018/8/8.
//  Copyright © 2018年 industiousonesoft. All rights reserved.
//

#import "SafariExtensionViewController.h"
#import <AppKit/AppKit.h>

@interface SafariExtensionViewController ()

@property (weak) IBOutlet NSTextField *displayTextField;

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

#pragma mark - Public Methods

- (void)updateDisplayText:(NSString *)text {
    [self.displayTextField setStringValue:text];
}

@end
