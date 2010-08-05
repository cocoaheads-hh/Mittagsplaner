//
//  MittagsplanerViewController.m
//  Mittagsplaner
//
//  Created by Daniel on 08.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MittagsplanerViewController.h"
#import "Seriously.h"

@implementation MittagsplanerViewController

@synthesize plzGPS;
@synthesize tableView;
@synthesize array;
@synthesize spinner;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(id)nearestPLZForLongitude:(float)lon andLatitude:(float)lat {
	id nearest=nil;
	float nearestDist=INFINITY;
	
	for(NSDictionary* plz in plzGPS) {
		float curDist=sqrtf(pow([[plz objectForKey:@"lon"] floatValue] - lon, 2) +
		pow([[plz objectForKey:@"lat"] floatValue] - lat, 2));
		
		if(curDist<nearestDist) {
			nearest=plz;
			nearestDist=curDist;
		}
	}
	return [nearest objectForKey:@"plz"];
}

-(void)loadPLZ {
	if(self.plzGPS)
		return;
	
	NSString *path=[[NSBundle mainBundle] pathForResource:@"postleitzahlen" 
												   ofType:@"txt"];
	NSArray *plzs=[[NSString stringWithContentsOfFile:path] componentsSeparatedByString:@"\n"];
	
	NSMutableArray *parsed=[NSMutableArray array];
	
	for(NSString* plz in plzs) {
		plz=[plz stringByReplacingOccurrencesOfString:@"  " withString:@" "];
		plz=[plz stringByReplacingOccurrencesOfString:@"  " withString:@" "];	
		NSArray *comp=[plz componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		NSAssert([comp count]==3, @"parser didn't work");
		[parsed addObject:[NSDictionary dictionaryWithObjectsAndKeys:
						   [comp objectAtIndex:0],
						   @"plz",
						   [comp objectAtIndex:1],
						   @"lon",
						   [comp objectAtIndex:2],
						   @"lat",
						   nil]];
	}
	self.plzGPS=parsed;

}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation; {
	
	[locationManager stopUpdatingLocation];

	id plz=[self nearestPLZForLongitude:newLocation.coordinate.longitude andLatitude:newLocation.coordinate.latitude];
	
	if (!plz) {
		plz=@"20357";
	}
	
	NSString *url = [NSString stringWithFormat:@"http://mittagsplaner.de/results.json?day=2010-08-05&address=%@&radius=1", plz];
	
    [Seriously get:url handler:^(id body, NSHTTPURLResponse *response, NSError *error) 
	 {
		 if (error) {
			 NSLog(@"Error: %@", error);
		 }
		 else {
			 NSLog(@"Look, JSON is parsed into a dictionary!");
			 self.array = [body valueForKey:@"food"]; 
			 self.tableView.alpha = 1.0;			 
			 [UIView beginAnimations:nil context:NULL];
			 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			 [UIView setAnimationDuration:10.5];
			 [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown 
									forView:self.tableView cache:YES];

			 [UIView commitAnimations];
			 [self.spinner stopAnimating];
			 [self.tableView reloadData];
			 NSLog(@"%@", body);
		 }
	 }];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if(!locationManager) {
		self.tableView.alpha = 0.0;
		[self.spinner startAnimating];
		locationManager=[CLLocationManager new];
		locationManager.delegate=self;
		[locationManager startUpdatingLocation];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

// MARK: UITableViewDataSource

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"standardCell"];
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
									  reuseIdentifier:@"standardCell"];
	}
	cell.textLabel.text = [[self.array objectAtIndex:indexPath.row] valueForKey:@"name"];
	return cell;
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.tableView = nil;
}


- (void)dealloc {
	[plzGPS release];
	[array release];
	[tableView release];
    [super dealloc];
}

@end
