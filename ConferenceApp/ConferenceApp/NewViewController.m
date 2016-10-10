//
//  NewViewController.m
//  ConferenceApp
//



#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://myconferenceevents.com/Services/Session.svc/GetSessionsByConferenceId?conferenceId=9"] //2
#import "NewViewController.h"
#import "Conference.h"
#import "DetailViewController.h"
#import "BookMarkedListViewController.h"
@interface NewViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation NewViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title  = @"Conference";
    
    
    UIBarButtonItem *Sessions =[[UIBarButtonItem alloc]initWithTitle:@"Sessions" style:UIBarButtonItemStylePlain target:self action:@selector(sessionView:)];
                                
        self.navigationItem.rightBarButtonItem=Sessions;
    

    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if([[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"].count == 0)
    {
        NSData* data = [NSData dataWithContentsOfURL:
                        kLatestKivaLoansURL];
        [self fetchedData:data];
    }


//    dispatch_async(kBgQueue, ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        kLatestKivaLoansURL];
//        [self performSelectorOnMainThread:@selector(fetchedData:)
//                               withObject:data waitUntilDone:YES];
//    });
    // Do any additional setup after loading the view from its nib.
}


- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSArray* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"json...: %i", json.count); //3

   if(json.count > 0)
   {
       [[DataBaseManager sharedInstance] deleteAllDataInEntity:@"Conference"];
       for (NSDictionary *dic in json)
       {
           [[DataBaseManager sharedInstance] insertDataInContactsTable:dic];
       }
       NSArray* latestLoans = [json valueForKey:@"SessionId"]; //2
       
       NSLog(@"loans: %@", latestLoans); //3
       
       for (NSDictionary *dicTemp in [[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"])
       {
           NSLog(@"Conference ... dic %@", dicTemp);
       }
       NSLog(@"GetDataBase.... %i", [[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"].count);
       
       [listTableView reloadData];
   }
}

#pragma mark - TableView DataSources

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"].count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    cell.textLabel.text = [[[[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"] objectAtIndex:indexPath.row] valueForKey:@"SessionId"];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Pushing next view
   //

           DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        detailView.detailSessionDic = [[[DataBaseManager sharedInstance] getDataBaseArrayOfEntity:@"Conference"] objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailView animated:YES];

    
}

-(IBAction)sessionView:(id)sender

{
    BookMarkedListViewController *bookmarkedListview = [[BookMarkedListViewController alloc] initWithNibName:@"BookMarkedListViewController" bundle:nil];
    [self.navigationController pushViewController:bookmarkedListview animated:YES];
    


}

////////////



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
