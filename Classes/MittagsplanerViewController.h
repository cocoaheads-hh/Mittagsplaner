//
//  MittagsplanerViewController.h
//  Mittagsplaner
//
//  Created by Daniel on 08.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class CLLocationManager;

@interface MittagsplanerViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView *tableView;
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, assign) IBOutlet UIActivityIndicatorView *spinner;
@property (copy) NSArray* plzGPS;

-(void)loadPLZ;
-(id)nearestPLZForLongitude:(float)lon andLatitude:(float)lat;

@end

