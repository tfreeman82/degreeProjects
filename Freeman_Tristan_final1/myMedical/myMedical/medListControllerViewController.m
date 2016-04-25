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
@synthesize allObjects, meds, detailDictionary, medDictionary;


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
        self.objectsPerPage = 20;
        
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    // creates PFQurery for class name "Medication"
    PFQuery *medicationQuery = [PFQuery queryWithClassName:@"Medication"];
    //initializes query in background and saves results in NSArray
    [medicationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        meds = [[NSMutableArray alloc]init];
        //loops through each object in returned array and assigns strings to values
        for (PFObject *object in objects){
            
            NSString *name = [object objectForKey:@"name"];
            NSString *form = [object objectForKey:@"form"];
            NSString *strength = [object objectForKey:@"strength"];
            NSString *quantity = [object objectForKey:@"quantity"];
            NSString *taken = [object objectForKey:@"taken"];
            NSString *rx = [object objectForKey:@"rxNumber"];
            NSString *scriber = [object objectForKey:@"scriber"];
            NSString *notes = [object objectForKey:@"notes"];
            
            [medicationQuery orderByDescending:@"name"];
            //calls custom object and assigns strings to each section.
            medInfo *med = [[medInfo alloc]initWithMedName:name form:form strength:strength qty:quantity taken:taken rx:rx scriber:scriber notes:notes];
            
            //adds custom object to mutableArray
            [meds addObject:med];
            
        }
        
    }];
    
        [super viewDidLoad];
    //logout button creation
    UIBarButtonItem *logOut = [[UIBarButtonItem alloc]initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(onLogOut:)];
    logOut.tintColor = [UIColor redColor];
    // add med button creation
    UIBarButtonItem *addMed = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddMed:)];
    [addMed setTintColor:[UIColor colorWithRed:0.725 green:0.82 blue:0.596 alpha:1]] /*#b9d198*/; 
    
    ViewController *loginView = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self presentViewController:loginView animated:YES completion:nil];
    
    self.navigationItem.leftBarButtonItem = logOut;
    self.navigationItem.rightBarButtonItem = addMed;
    [[self navigationItem]setRightBarButtonItem:addMed];
    [[self navigationItem]setLeftBarButtonItem:logOut];
    
        
   
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        //[self loadObjects];

}


//-(void)countCallback:(NSNumber*)count error:(NSError*)error
//{
//    if (!error) {
//        NSLog(@"Count: %d", [count intValue]);
//    }else{
//        NSLog(@"error with count");
//    }
//}

- (PFQuery *)query{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"name"];
    
    return query;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

// IBAction for adding medication
-(IBAction)onAddMed:(id)sender
{
    addMedicationViewController *addMeds = [[addMedicationViewController alloc]initWithNibName:@"addMedicationViewController" bundle:nil];
    if (addMeds !=nil) {
        [self presentViewController:addMeds animated:YES completion:nil];
    }
}
//IBAction for log out
-(IBAction)onLogOut:(id)sender
{
    [PFUser logOut];
    ViewController *loginView = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self presentViewController:loginView animated:YES completion:nil];
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    // sets the medArray to the objects loaded
    medArray = self.objects;
    // This method is called every time objects are loaded from Parse via the PFQuery
}

//- (void)objectsWillLoad {
//    [super objectsWillLoad];
//    
//    // This method is called before a PFQuery is fired to get more objects
//}


//Query for table view
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"name"];
   
    
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




  //Override if you need to change the ordering of objects in the table.
// - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
// return [objects objectAtIndex:indexPath.row];
// }



 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
// - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
// static NSString *CellIdentifier = @"NextPage";
// 
// UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
// 
// if (cell == nil) {
// cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
// }
// 
// cell.selectionStyle = UITableViewCellSelectionStyleNone;
// cell.textLabel.text = @"Load more...";
// 
// return cell;
// }


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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    medicationDetailsViewController *medDetails = [[medicationDetailsViewController alloc]initWithNibName:@"medicationDetailsViewController" bundle:nil];
    if (medDetails !=nil) {
        // assigns detailDictionary to each indexpath of medArray
        detailDictionary = [medArray objectAtIndex:indexPath.row];
        medDetails.recievedDictionary = detailDictionary;
    }
        
    [self presentViewController:medDetails animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
            
            
        
};
   
   
    


@end
