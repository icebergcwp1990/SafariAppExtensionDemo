//
//  SafariExtensionHandler.m
//  MyFirstSafariAppExtension
//
//  Created by iceberg on 2018/8/7.
//  Copyright © 2018年 industiousonesoft. All rights reserved.
//

#import "SafariExtensionHandler.h"
#import "SafariExtensionViewController.h"
#import <SafariServices/SFSafariApplication.h>

@interface SafariExtensionHandler ()

@end

@implementation SafariExtensionHandler

- (void)messageReceivedWithName:(NSString *)messageName fromPage:(SFSafariPage *)page userInfo:(NSDictionary *)userInfo {
    
    if ([messageName isEqualToString:@"DOMContentLoaded"]) {
        
        [page getPagePropertiesWithCompletionHandler:^(SFSafariPageProperties *properties) {
            NSLog(@"The extension received a message (%@) from a script injected into (%@) with userInfo (%@)", messageName, properties.url, userInfo);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SafariExtensionViewController sharedController] updateDisplayText:[properties.url absoluteString]];
                [self updateBadgeText:@"1" ofToolbarItem:nil];
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

#warning: 每一次弹出显示popover都会创建一个新的SafariExtensionHandler对象，因此不建议在该对象添加成员属性
- (void)popoverWillShowInWindow:(SFSafariWindow *)window {
    
    [window getActiveTabWithCompletionHandler:^(SFSafariTab * _Nullable activeTab) {
       
        [activeTab getActivePageWithCompletionHandler:^(SFSafariPage * _Nullable activePage) {
            
            //如果是Exrension是第一次加载，则reload一次当前页面，确保script脚步顺利注入。
            if (![[SafariExtensionViewController sharedController] isFirstTimeToLaunchAppEx]) {
                [activePage reload];
                [[SafariExtensionViewController sharedController] setFirstTimeToLaunchAppEx:YES];
            }else {
                [activePage dispatchMessageToScriptWithName:@"MessageFromSafariAppExtension" userInfo:@{@"name":@"the first safari app extension"}];
                
                [activePage getPagePropertiesWithCompletionHandler:^(SFSafariPageProperties * _Nullable properties) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[SafariExtensionViewController sharedController] updateDisplayText:[properties.url absoluteString]];
                        [self updateBadgeText:@"1" ofToolbarItem:nil];
                    });
                    
                }];
            }

        }];
        
    }];
    
}

- (void)popoverDidCloseInWindow:(SFSafariWindow *)window {
    
}

#pragma mark - Private Helper

- (void)updateBadgeText:(NSString *)text ofToolbarItem:(SFSafariToolbarItem *)toolbarItem {
    
    if (!text) {
        return;
    }
    
    if (toolbarItem) {
        [toolbarItem setBadgeText:text];
    }else {
        [SFSafariApplication getActiveWindowWithCompletionHandler:^(SFSafariWindow * _Nullable activeWindow) {
            [activeWindow getToolbarItemWithCompletionHandler:^(SFSafariToolbarItem * _Nullable toolbarItem) {
                [toolbarItem setBadgeText:text];
            }];
        }];
    }
    
}

@end
