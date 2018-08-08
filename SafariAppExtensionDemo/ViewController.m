//
//  ViewController.m
//  SafariAppExtensionDemo
//
//  Created by iceberg on 2018/8/7.
//  Copyright © 2018年 industiousonesoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak) IBOutlet NSTextField *displayTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObservers];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark - Observer && Handle

- (void)addObservers {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMessageFromContainingApp:) name:@"MessageFromContainingApp" object:nil];
}

- (void)handleMessageFromContainingApp:(NSNotification *)notify {
    
    id obj = [notify object];
    
    if ([obj isKindOfClass:[NSString class]]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.displayTextField setStringValue:obj];
            
        });
    }
    
}

@end
