//
//  SafariExtensionViewController.h
//  MySecondSafariAppExtension
//
//  Created by iceberg on 2018/8/8.
//  Copyright © 2018年 industiousonesoft. All rights reserved.
//

#import <SafariServices/SafariServices.h>

@interface SafariExtensionViewController : SFSafariExtensionViewController

+ (SafariExtensionViewController *)sharedController;

- (void)updateDisplayText:(NSString *)text;

@end
