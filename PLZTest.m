//
//  PLZTest.m
//  Mittagsplaner
//
//  Created by Stefan Munz on 8/5/10.
//  Copyright 2010 Cellular GmbH. All rights reserved.
//

#import "PLZTest.h"
#import "MittagsplanerViewController.h"

@implementation PLZTest

-(void)setUp {
	controller=[NSClassFromString(@"MittagsplanerViewController") new];
	[controller loadPLZ];
}

-(void)tearDown {
	[controller release];
}


-(void)testPostleitZahl {
	NSLog(@"%@", [controller nearestPLZForLongitude:12.07 andLatitude:50.76]);
	STAssertEqualObjects([controller nearestPLZForLongitude:12.07 andLatitude:50.76], @"07570", @"Postleitzahl wird richtig ermittelt");
}

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void) testMath {
    
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
    
}


#endif


@end
