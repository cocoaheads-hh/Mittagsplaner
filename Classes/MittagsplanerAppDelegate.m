//
//  MittagsplanerAppDelegate.m
//  Mittagsplaner
//
//  Created by Daniel on 08.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "MittagsplanerAppDelegate.h"

#import "MittagsplanerViewController.h"

@implementation MittagsplanerAppDelegate


@synthesize window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
    // Override point for customization after app launch. 
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}

- (void)dealloc {

    [window release];
    [viewController release];
    [super dealloc];
}

@end

