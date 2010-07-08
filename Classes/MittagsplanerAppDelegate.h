//
//  MittagsplanerAppDelegate.h
//  Mittagsplaner
//
//  Created by Daniel on 08.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MittagsplanerViewController;

@interface MittagsplanerAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;

    MittagsplanerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet MittagsplanerViewController *viewController;

@end

