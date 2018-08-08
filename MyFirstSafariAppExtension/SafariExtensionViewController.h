//
//  SafariExtensionViewController.h
//  MyFirstSafariAppExtension
//
//  Created by iceberg on 2018/8/7.
//  Copyright © 2018年 industiousonesoft. All rights reserved.
//

#import <SafariServices/SafariServices.h>

@interface SafariExtensionViewController : SFSafariExtensionViewController

@property (assign, setter=setFirstTimeToLaunchAppEx:) BOOL isFirstTimeToLaunchAppEx;

+ (SafariExtensionViewController *)sharedController;

- (void)updateDisplayText:(NSString *)text;

@end
