//
//  SafariExtensionHandler.m
//  MySecondSafariAppExtension
//
//  Created by iceberg on 2018/8/8.
//  Copyright © 2018年 industiousonesoft. All rights reserved.
//

#import "SafariExtensionHandler.h"
#import "SafariExtensionViewController.h"

@interface SafariExtensionHandler ()

@end

@implementation SafariExtensionHandler

- (void)messageReceivedWithName:(NSString *)messageName fromPage:(SFSafariPage *)page userInfo:(NSDictionary *)userInfo {
   
    if ([messageName isEqualToString:@"DOMContentLoaded"]) {
        
        [page getPagePropertiesWithCompletionHandler:^(SFSafariPageProperties *properties) {
            NSLog(@"The extension received a message (%@) from a script injected into (%@) with userInfo (%@)", messageName, properties.url, userInfo);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SafariExtensionViewController sharedController] updateDisplayText:[properties.url absoluteString]];
            });
            
        }];
    }else {
        NSLog(@"Received a unknown message named: %@", messageName);
    }
    
}

- (void)toolbarItemClickedInWindow:(SFSafariWindow *)window {
    // This method will be called when your toolbar item is clicked.
    NSLog(@"The extension's toolbar item was clicked");
}

- (void)validateToolbarItemInWindow:(SFSafariWindow *)window validationHandler:(void (^)(BOOL enabled, NSString *badgeText))validationHandler {
    // This method will be called whenever some state changes in the passed in window. You should use this as a chance to enable or disable your toolbar item and set badge text.
    validationHandler(YES, nil);
}

- (SFSafariExtensionViewController *)popoverViewController {
    return [SafariExtensionViewController sharedController];
}

- (void)popoverWillShowInWindow:(SFSafariWindow *)window {
    
    [window getActiveTabWithCompletionHandler:^(SFSafariTab * _Nullable activeTab) {
        
        [activeTab getActivePageWithCompletionHandler:^(SFSafariPage * _Nullable activePage) {
            
            [activePage dispatchMessageToScriptWithName:@"MessageFromSafariAppExtension" userInfo:@{@"name":@"the second safari app extension"}];
            
        }];
        
    }];
    
}

@end
