//
//  medListControllerViewController.m
//  myMedical
//
//  Created by Tristan Freeman on 11/11/13.
//  Copyright (c) 2013 Tristan Freeman. All rights reserved.
//

#import "medListControllerViewController.h"
#import "ViewController.h"
#import "signUpViewController.h"
#import "addMedicationViewController.h"
#import "medicationManager.h"
#import "medicationDetailsViewController.h"

@implementation medListControllerViewController
@synthesize receivedDict, recievedQuery;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
                
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Medication";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // The title for this table in the Navigation Controller.
        self.title = @"Medications";
        self.tabBarController.tabBarItem.title = @"Medications";
        self.tabBarItem.image = [UIImage imageNamed:@"10-medical.png"];

        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 5;
        
        
        
        
        

//        UINavigationBar *navBar = [[UINavigationBar alloc]init];
//        [self.view addSubview:navBar];

        //self.navigationController.navigationBar = navBar;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *logOut = [[UIBarButtonItem alloc]initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(onLogOut:)];
    logOut.tintColor = [UIColor redColor];
    UIBarButtonItem *addMed = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddMed:)];

    
    ViewController *loginView = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self presentViewController:loginView animated:YES completion:nil];
    
    self.navigationItem.leftBarButtonItem = logOut;
    self.navigationItem.rightBarButtonItem = addMed;
    [[self navigationItem]setRightBarButtonItem:addMed];
    [[self navigationItem]setLeftBarButtonItem:logOut];
    
        
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    }

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    ViewController *loginView = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
//    [self presentViewController:loginView animated:NO completion:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)onAddMed:(id)sender
{
    addMedicationViewController *addMeds = [[addMedicationViewController alloc]initWithNibName:@"addMedicationViewController" bundle:nil];
    if (addMeds !=nil) {
        [self presentViewController:addMeds animated:YES completion:nil];
    }
}

-(IBAction)onLogOut:(id)sender
{
    [PFUser logOut];
    ViewController *loginView = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self presentViewController:loginView animated:YES completion:nil];
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"name"];
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"name"];
    NSString *strength = [object objectForKey:@"strength"];
    NSString *form = [object objectForKey:@"form"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", strength, form];
    
    return cell;
}



/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - Table view data source

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
//-(PFQuery*)query{
//    PFQuery *query = [PFQuery queryWithClassName:@"Medication"];
//    [query selectKeys:@[@"name", @"form", @"strength", @"quantity", @"taken", @"rxNumber"]];
//    
//    NSArray *results = [query findObjects:nil];
//    NSLog(@"%@", [results description]);
//
//    return query;
//}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //medicationManager *meds = [medArray objectAtIndex:indexPath.row];
    medicationDetailsViewController *medDetails = [[medicationDetailsViewController alloc]initWithNibName:@"medicationDetailsViewController" bundle:nil];
    
    NSMutableArray *allObjects = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Medication"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for(NSDictionary *object in objects){
                //[allObjects addObjectsFromArray:objects];
                
                NSString *medName = [object objectForKey:@"name"];
                NSString *medForm = [object objectForKey:@"form"];
                medDetails.nameLabel.text = medName;
                medDetails.formLabel.text = [object objectForKey:@"form"];
                medDetails.strengthLabel.text = [object objectForKey:@"strength"];
                medDetails.qtyLabel.text = [object objectForKey:@"quantity"];
                medDetails.takenLabel.text = [object objectForKey:@"taken"];
                medDetails.rxLabel.text = [object objectForKey:@"rxNumber"];
                medDetails.prescriberLabel.text = [object objectForKey:@"scriber"];
                medDetails.notesLabel.text = [object objectForKey:@"notes"];
                
                NSLog(@"%@ %@", medName, medForm);
            }
            
        }else{
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
       //allObjects = [
    
    //medDetails.receivedObject = meds;
    
    [self presentViewController:medDetails animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}


@end
